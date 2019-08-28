kubectl apply -f ./persistence-layer.yml
kubectl expose deployment persistence-layer --type=LoadBalancer
kubectl apply -f ./business-layer.yml
kubectl expose deployment business-layer --type=LoadBalancer
kubectl apply -f ./ui-layer.yml
kubectl expose deployment ui-layer --type=LoadBalancer
minikube service ui-layer --url
