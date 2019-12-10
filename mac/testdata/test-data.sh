#This scripts loads sample testdata
script_to_run=$1

export POSTGRES_POD=$(kubectl get pods -o wide | grep "postgres" | awk '{ print $1 }')
#export DB_USER=`echo -n ${SECRET_OF_DB_USERNAME} | base64 --decode`
echo ${POSTGRES_POD}

kubectl exec -it $(kubectl get pods -n take-on | grep "database" | awk '{ print $1}') /bin/ash -n take-on
DB_USER=`printenv | grep "POSTGRES_USER"`
DB_NAME=`printenv | grep "POSTGRES_DB"`
kubectl exec -ti $(kubectl get pods -n take-on | grep "database" | awk '{ print $1}') /bin/ash -n take-on bash
# Check for no parameters or blank paremeter
if [ $# -eq 0 ] || [ -z "$1" ]
  then
    echo "No arguments supplied - Please enter 0066 or dummy-data"
    exit 1
fi
# Script to clear down DB and set all schema
./clearDB.sql

if [ $script_to_run -eq "0066"]
  then
    kubectl cp testdata/0066-data.sql ${POSTGRES_POD}:/tmp
    kubectl exec -it ${POSTGRES_POD} -- psql -d ${DB_NAME}  -U ${DB_USER} -p 5432 -f "/tmp/0066-data.sql"
    error_code=`echo $?`
    if [ $error_code -ne 0 ];
    then
      echo "error running 0066 data sql"
      exit 1
    else
      echo "0066 Script run successfully"
    fi
      exit 1
elif [[ $script_to_run -eq "dummy-data" ]]; then
  kubectl cp testdata/test-data.sql ${POSTGRES_POD}:/tmp
  kubectl exec -it ${POSTGRES_POD} -- psql -d ${DB_NAME}  -U ${DB_USER} -p 5432 -f "/tmp/test-data.sql"
  error_code=`echo $?`
  if [ $error_code -ne 0 ];
  then
    echo "error running dummy-data sql"
    exit 1
  else
    echo "dummy-data Script run successfully"
  fi
    exit 1
fi
