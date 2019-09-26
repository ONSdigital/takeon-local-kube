#! /bin/bash

dbuser=u$(openssl rand -hex 7 | tr -cd "[:alnum:]")
dbuserpass=p$(openssl rand -hex 7 | tr -cd "[:alnum:]")
db_username=u$(openssl rand -hex 7 | tr -cd "[:alnum:]")
db_password=p$(openssl rand -hex 7 | tr -cd "[:alnum:]")

db_username_encoded=$(echo -n ${db_username} | base64) 
db_password_encoded=$(echo -n ${db_password} | base64)


takeondb=takeondb

echo "export DBUSER=${dbuser}
export DBUSERPASS=${dbuserpass}
export DB_USERNAME=${db_username}
export DB_PASSWORD=${db_password}
export DB_USERNAME_ENCODED=${db_username_encoded}
export DB_PASSWORD_ENCODED=${db_password_encoded}
export DB_NAME=${takeondb}" > /tmp/minikube_env
