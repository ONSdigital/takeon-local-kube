#! /bin/bash

echo
echo "(Re)creating all containers and deploying to a local minikube installation"
echo


#minikube delete
#minikube start

./init.sh
./postgres.sh
./graphql.sh 
./persistence.sh 
./business.sh 
./ui.sh 

wait
echo
echo "Complete"
cp /tmp/minikube_env ~/
