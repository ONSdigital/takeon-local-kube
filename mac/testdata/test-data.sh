#This scripts loads sample testdata
source ./env
export POSTGRES_POD=$(kubectl get pods -o wide | grep "postgres" | awk '{ print $1 }')
export DB_USER=`echo -n ${SECRET_OF_DB_USERNAME} | base64 --decode`
echo ${POSTGRES_POD}
echo ${DB_USER}
echo ${DB_NAME}
kubectl cp ../env ${POSTGRES_POD}:/tmp
kubectl cp ./test-data.sql ${POSTGRES_POD}:/tmp
kubectl exec -it ${POSTGRES_POD} -- psql -d ${DB_NAME}  -U ${DB_USER} -p 5432 -f "/tmp/test-data.sql"
