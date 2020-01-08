#! /bin/bash

eval $(minikube docker-env)
source kube_env
. kube_functions

log "Removing existing ${QL_service} (if it exists)"
delete_deployment ${namespace} ${QL_service}
delete_service ${namespace} ${QL_service}

log "Removing existing ${PL_service} (if it exists)"
delete_deployment ${namespace} ${PL_service}
delete_service ${namespace} ${PL_service}

log "Removing existing ${DB_service} (if it exists)"
delete_deployment ${namespace} ${DB_service}
delete_service ${namespace} ${DB_service}
log ""

log "Generating random username and password"
./generate_secrets.sh

log "Building ${DB_image} using ${DB_repo}"
docker build -t ${DB_image} ${DB_repo}
sleep 2

apply secrets.yml
apply postgres.yml

log "Waiting for DB container to start"
sleep 5

export POSTGRES_POD=$(kubectl get pods -n ${namespace} -o wide | grep "${DB_service}" | awk '{ print $1 }')
export DB_SERVER_IP=$(kubectl get pods -n ${namespace} -o wide | grep "${DB_service}" | awk '{ print $6 }')

echo POD: ${POSTGRES_POD}
echo USERNAME: ${DB_USERNAME}
echo DBNAME: ${DB_name}
echo DB_SERVER_IP: ${DB_SERVER_IP}

log "Copying & running test data into container"
kubectl cp ../mac/testdata/create_schema.sql ${namespace}/${POSTGRES_POD}:/tmp
kubectl cp ../mac/testdata/insert_reference_data.sql ${namespace}/${POSTGRES_POD}:/tmp
kubectl cp ../mac/testdata/survey-0066.sql ${namespace}/${POSTGRES_POD}:/tmp
kubectl cp ../mac/testdata/test-data-0066.sql ${namespace}/${POSTGRES_POD}:/tmp
# kubectl cp ../mac/testdata/survey-0076.sql ${namespace}/${POSTGRES_POD}:/tmp
# kubectl cp ../mac/testdata/test-data-0076.sql ${namespace}/${POSTGRES_POD}:/tmp

log "Running create_schema.sql"
kubectl exec -it -n ${namespace} ${POSTGRES_POD} -- psql -d ${DB_name} -U ${DB_USERNAME} -p 5432 -f "/tmp/create_schema.sql"
log "Running insert_reference_data.sql"
kubectl exec -it -n ${namespace} ${POSTGRES_POD} -- psql -d ${DB_name} -U ${DB_USERNAME} -p 5432 -f "/tmp/insert_reference_data.sql"
log "Running survey-0066.sql"
kubectl exec -it -n ${namespace} ${POSTGRES_POD} -- psql -d ${DB_name} -U ${DB_USERNAME} -p 5432 -f "/tmp/survey-0066.sql"
log "Running test-data-0066.sql"
kubectl exec -it -n ${namespace} ${POSTGRES_POD} -- psql -d ${DB_name} -U ${DB_USERNAME} -p 5432 -f "/tmp/test-data-0066.sql"
# kubectl exec -it -n ${namespace} ${POSTGRES_POD} -- psql -d ${DB_name} -U ${DB_USERNAME} -p 5432 -f "/tmp/survey-0076.sql"
# kubectl exec -it -n ${namespace} ${POSTGRES_POD} -- psql -d ${DB_name} -U ${DB_USERNAME} -p 5432 -f "/tmp/test-data-0076.sql"


log "Adding DB server settings to /tmp/minikub_env"
echo kubectl exec -it -n takeon ${POSTGRES_POD} -- psql -d ${DB_name} -U ${DB_USERNAME} -p 5432
echo "export DB_SERVER=${POSTGRES_POD}
export DB_SERVER_IP=${DB_SERVER_IP}" >> /tmp/minikube_env

log "Exposing ${DB_service}"
kubectl expose deployment ${DB_service} --type=LoadBalancer -n ${namespace}
