# Main script that installs persistence-layer, business-layer and ui-layer
source ./env
export DB_SERVER_IP=$(kubectl get pods -o wide | grep "postgres" | awk '{ print $6 }')
echo "DB_SERVER_IP :" ${DB_SERVER_IP}
echo "DB_NAME :" ${DB_NAME}
cat persistence-layer.yml | envsubst  |  kubectl apply -f -
kubectl expose deployment persistence-layer --type=LoadBalancer
cat business-layer.yml | envsubst |  kubectl apply -f -
kubectl expose deployment business-layer --type=LoadBalancer
cat ui-layer.yml | envsubst |  kubectl apply -f -
kubectl expose deployment ui-layer --type=LoadBalancer

URL=$(minikube service ui-layer --url)

echo "UI URL: $URL"
