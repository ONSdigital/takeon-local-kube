kubectl delete deployment,service business-layer
kubectl delete deployment,service ui-layer
kubectl delete deployment,service persistence-layer
kubectl delete deployment postgres
kubectl delete Secret database-secret-config
kubectl delete PersistentVolumeClaim postgres-pv-claim
