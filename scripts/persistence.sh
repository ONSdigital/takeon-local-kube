#! /bin/bash

eval $(minikube docker-env)
source kube_env
. kube_functions

log "Using repo:" ${PL_repo}
log "Image: " ${PL_image}
log "Service: " ${PL_service}


log "Removing existing ${container} (if it exists)"
delete_deployment ${namespace} ${PL_service}
delete_service ${namespace} ${PL_service}

log "Building ${PL_image} from ${PL_repo}"
docker build -t ${PL_image} ${PL_repo}

sleep 1

log "Applying yml"
apply persistence.yml

kubectl expose deployment ${PL_service} --type=LoadBalancer -n ${namespace}
