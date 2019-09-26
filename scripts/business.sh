#! /bin/bash

eval $(minikube docker-env)
source kube_env
. kube_functions

log "Removing existing ${BL_service} (if it exists)"
delete_deployment ${namespace} ${BL_service}
delete_service ${namespace} ${BL_service}

log "Building ${BL_image} from ${BL_repo}"
docker build -t ${BL_image} ${BL_repo}

sleep 1

log "Applying yml"
apply business.yml

kubectl expose deployment ${BL_service} --type=LoadBalancer -n ${namespace}
