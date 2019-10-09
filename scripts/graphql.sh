#! /bin/bash

eval $(minikube docker-env)
source kube_env
. kube_functions


log "Image: " ${QL_image}

log "Removing existing Graphql deployment (if it exists)"
delete_deployment ${namespace} ${QL_image}
delete_service ${namespace} ${QL_image}

log "Get postgraphile dockerfile"
docker pull graphile/postgraphile 
docker tag graphile/postgraphile ${QL_image}

log "Deploying graphql"
apply graphql.yml

log "Exposing ${QL_service}"
kubectl expose deployment ${QL_service} --type=LoadBalancer -n ${namespace}

QL_URL=$(minikube service ${QL_service} -n ${namespace} --url)
echo "QL URL: ${QL_URL}/graphiql"
echo "QL URL: ${QL_URL}/graphql"
