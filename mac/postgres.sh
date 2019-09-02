#Script to install postgres in a minikube container. Once the postgress pod shows running, you can go to run layers.sh
source ./env
cat postgres.yml | envsubst |  kubectl apply -f -
echo "kubectl get pods -o wide"
kubectl get pods -o wide
