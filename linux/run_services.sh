#! /bin/bash

while getopts ":d:p:b:u:q:r:" opt; do
  case $opt in
    d) db="$OPTARG"
    ;;
    p) pl="$OPTARG"
    ;;
    b) bl="$OPTARG"
	  ;;
    u) ui="$OPTARG"
	  ;;
    q) ql="$OPTARG"
	  ;;
    r) repo="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG"  >&2
	exit 1 
    ;;
  esac
done
echo $db
echo $pl
echo $bl
echo $ui
echo $ql

# create database username and password
username=$(python3 -c 'import gen_words as g; g.gen_name()')
password=$(python3 -c 'import gen_words as g; g.gen_pass()')

# Start minikube context

minikube start
kubectl create namespace take-on
eval $(minikube docker-env)

# Create entry script for database

echo "psql -f /takeon-db/tables.sql
psql -d validationdb -c \"CREATE USER $username WITH PASSWORD '$password';\"
psql -d validationdb -c \"GRANT USAGE ON SCHEMA dev01 TO $username;\"
psql -d validationdb -c \"GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA dev01 TO $username;\"
psql -f /takeon-db/edge_cases.sql;" > ../postgres/entry.sh

echo "Get postgraphile dockerfile"
curl https://raw.githubusercontent.com/graphile/postgraphile/master/Dockerfile > dockerfile

# Build images
echo ""
echo "##### BUILDING DOCKER IMAGES #####"
echo ""
docker build -t takeon-dev-postgres $db
docker build -t takeon-dev-pl $pl 
docker build -t takeon-dev-bl $bl 
docker build -t takeon-dev-ui $ui
docker pull graphile/postgraphile 
docker tag graphile/postgraphile graphql
wait
echo "Images built"
# Add service account

kubectl create serviceaccount api-service-account -n take-on

cat << EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: api-access
  namespace: take-on
rules:
  -
    apiGroups:
      - ""
    resources:
      - services
      - endpoints
    verbs: ["*"]
  - nonResourceURLs: ["*"]
    verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: api-access
  namespace: take-on
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: api-access
subjects:
- kind: ServiceAccount
  name: api-service-account
  namespace: take-on
EOF

# Create database

cat <<EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: database-service
  namespace: take-on
spec:
  replicas: 1
  template:
    metadata:
      name: database-service
      labels:
        app: database-service
    spec:
      serviceAccountName: api-service-account
      containers:
      - name: database-service
        image: takeon-dev-postgres
        imagePullPolicy: Never
        ports:
        - containerPort: 5432
EOF

echo "Waiting for DB to start"
sleep 30s
export DB_SERVER=$(kubectl get pods -o wide -n take-on | grep "database" | awk '{ print $6 }')
echo $DB_SERVER
echo ""
echo "The database should now be running please run the following:"
echo "kubectl exec -it $(kubectl get pods -o wide -n take-on | grep "database" | awk '{ print $1 }') /bin/ash -n take-on"
echo "./entry.sh"
sleep 20s
echo ""
### GET DATABASE LOCATION FOR GRAPHQL ###
kubectl expose deployment database-service --type=LoadBalancer -n take-on
location=$(kubectl get service -n take-on | grep database | awk '{ print $3 }')
echo "DATABASE LOCATION: $location"
# Create persistence service
cat << EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: persistence-layer
  namespace: take-on
spec:
  replicas: 1
  template:
    metadata:
      name: persistence-layer
      labels:
        app: persistence-layer
    spec:
      serviceAccountName: api-service-account
      containers:
      - name: persistence-layer
        env:
          - name: DATASOURCE_USERNAME
            value: $username
          - name: DATASOURCE_PASSWORD
            value: $password
          - name: DB_SERVER
            value: $DB_SERVER
          - name: DB_PORT
            value: "5432"
          - name: DB_NAME
            value: validationdb
        image: takeon-dev-pl
        imagePullPolicy: Never
        ports:
        - containerPort: 8090
EOF

kubectl expose deployment persistence-layer --type=LoadBalancer -n take-on


cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: graphql
  namespace: take-on
  labels:
    app: graphql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: graphql
  template:
    metadata:
      labels:
        app: graphql
    spec:
      serviceAccountName: api-service-account
      containers:
      - name: graphql
        image: graphql
        imagePullPolicy: Never
        args: ['--connection', 'postgres://$username:$password@$location/validationdb', '--schema', 'dev01', '-j', '-a', '--watch']
        ports:
        - containerPort: 5000
EOF
kubectl expose deployment graphql --type=LoadBalancer -n take-on

# apiVersion: v1
# kind: Service
# metadata:
#   name: graphql
#   namespace: take-on
#   labels:
#     app: graphql
# spec:
#   ports:
#   - port: 5001
#     targetPort: 5000
#     protocol: TCP
#   selector:
#     app: graphql
#   type: ClusterIP



# Create business service
cat <<EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: business-layer
  namespace: take-on
spec:
  replicas: 1
  template:
    metadata:
      name: business-layer
      labels:
        app: business-layer
    spec:
      serviceAccountName: api-service-account
      containers:
      - name: business-layer
        image: takeon-dev-bl
        imagePullPolicy: Never
        ports:
        - containerPort: 8088
EOF

kubectl expose deployment business-layer --type=LoadBalancer -n take-on

# Create UI service
cat <<EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ui-layer
  namespace: take-on
spec:
  replicas: 1
  template:
    metadata:
      name: ui-layer
      labels:
        app: ui-layer
    spec:
      serviceAccountName: api-service-account
      containers:
      - name: ui-layer
        image: takeon-dev-ui
        imagePullPolicy: Never
        ports:
        - containerPort: 5000
EOF

kubectl expose deployment ui-layer --type=LoadBalancer -n take-on

URL=$(minikube service ui-layer -n take-on --url)

echo "UI URL: $URL"
