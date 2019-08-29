#! /bin/bash

usage="$(basename "$0") [-h][-d file] -- script to automatically create our microservices locally

where:
	-h shows this help text
	-d database yaml file"
while getopts ":d:p:b:u:r:" opt; do
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
    \?) echo "Invalid option -$OPTARG"  >&2
	exit 1 
    ;;
  esac
done
echo $db
echo $pl
echo $bl
echo $ui
# Start minikube context

minikube start
eval $(minikube docker-env)

kubectl create -f $db

export DB_SERVER=$(kubectl get pods -o wide | grep "postgres" | awk '{ print $6 }')
docker build -t takeon-dev-pl $pl
docker build -t takeon-dev-bl $bl
docker build -t takeon-dev-ui $ui

# Add service account

kubectl create serviceaccount api-service-account

cat << EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: api-access
rules:
  -
    apiGroups:
      - ""
      - apps
      - autoscaling
      - batch
      - extensions
      - policy
      - rbac.authorization.k8s.io
    resources:
      - componentstatuses
      - configmaps
      - daemonsets
      - deployments
      - events
      - endpoints
      - horizontalpodautoscalers
      - ingress
      - jobs
      - limitranges
      - namespaces
      - nodes
      - pods
      - persistentvolumes
      - persistentvolumeclaims
      - resourcequotas
      - replicasets
      - replicationcontrollers
      - serviceaccounts
      - services
    verbs: ["*"]
  - nonResourceURLs: ["*"]
    verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: api-access
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: api-access
subjects:
- kind: ServiceAccount
  name: api-service-account
  namespace: default
EOF

# Create persistence service

cat << EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: persistence-layer
  namespace: default
spec:
  replicas: 1
  template:
    metadata:
      name: persistence-layer
      labels:
        app: persistence-layer
    spec:
      containers:
      - name: persistence-layer
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

kubectl expose deployment persistence-layer --type=LoadBalancer

# Create business service
cat <<EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: business-layer
  namespace: default
spec:
  replicas: 1
  template:
    metadata:
      name: business-layer
      labels:
        app: business-layer
    spec:
      containers:
      - name: business-layer
        image: takeon-dev-bl
        imagePullPolicy: Never
        ports:
        - containerPort: 8088
EOF

kubectl expose deployment business-layer --type=LoadBalancer

# Create UI service
cat <<EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ui-layer
  namespace: default
spec:
  replicas: 1
  template:
    metadata:
      name: ui-layer
      labels:
        app: ui-layer
    spec:
      serviceAccountName: api-
      containers:
      - name: ui-layer
        image: takeon-dev-ui
        imagePullPolicy: Never
        ports:
        - containerPort: 5000
EOF

kubectl expose deployment ui-layer --type=LoadBalancer

URL=$(minikube service ui-layer --url)

echo "UI URL: $URL"
