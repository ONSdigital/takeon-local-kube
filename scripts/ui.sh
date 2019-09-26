#! /bin/bash

eval $(minikube docker-env)
source kube_env
. kube_functions

log "Removing existing ${UI_service} (if it exists)"
delete_deployment ${namespace} ${UI_service}
delete_service ${namespace} ${UI_service}

log "Building ${UI_image} from ${UI_repo}"
docker build -t ${UI_image} ${UI_repo}

sleep 1

log "Applying yml"
apply ui.yml

kubectl expose deployment ${UI_service} --type=LoadBalancer -n ${namespace}

URL=$(minikube service ${UI_service} -n ${namespace} --url)
echo "UI URL: $URL"
