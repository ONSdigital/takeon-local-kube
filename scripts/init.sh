#! /bin/bash

eval $(minikube docker-env)
source kube_env
. kube_functions

kubectl delete namespace ${namespace}
kubectl create namespace ${namespace}
kubectl create serviceaccount api-service-account -n ${namespace}
apply init.yml
