#! /bin/bash

usage="$(basename "$0") [-h][-d file] -- script to automatically create our microservices locally

where:
	-h shows this help text
	-d database yaml file"
while getopts ":d:p:b:u:r:x:y:" opt; do
  case $opt in
    d) db="$OPTARG"
    ;;
    p) pl="$OPTARG"
    ;;
    b) bl="$OPTARG"
	  ;;
    u) ui="$OPTARG"
	  ;;
    r) repo="$OPTARG"
	  ;;
    x) username="$OPTARG"
    ;;
    y) password="$OPTARG"
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
echo $username
echo $password
# Start minikube context

minikube start
kubectl create namespace take-on
eval $(minikube docker-env)

# kubectl create -f $db

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: database-credentials
  namespace: take-on
data:
  datasource_username: $username
  datasource_password: $password
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pv-claim
  namespace: take-on
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 32Gi
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: postgres
  namespace: take-on
spec:
  template:
    metadata:
      labels:
        app: postgres
    spec:
      volumes:
        - name: postgres-storage
          persistentVolumeClaim:
            claimName: postgres-pv-claim
      containers:
        - image: postgres
          name: postgres
          env:
            - name: DATASOURCE_USERNAME
              valueFrom:
                configMapKeyRef:
                  name: database-credentials
                  key: datasource_username
            - name: DATASOURCE_PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: database-credentials
                  key: datasource_password
            - name: POSTGRES_DB
              value: validationdb
            - name: PGDATA
              value: /var/lib/postgresql/data/pgdata
          ports:
            - containerPort: 5432
              name: postgres
          volumeMounts:
            - name: postgres-storage
              mountPath: /var/lib/postgresql/data
EOF
echo "Waiting for DB to start"
sleep 90s
export DB_SERVER=$(kubectl get pods -o wide -n take-on | grep "postgres" | awk '{ print $6 }')
echo $DB_SERVER
docker build -t takeon-dev-pl $pl
docker build -t takeon-dev-bl $bl
docker build -t takeon-dev-ui $ui


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
