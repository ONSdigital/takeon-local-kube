#! /bin/bash

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
