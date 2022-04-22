set -x

kubectl delete ns carvel-workshop-examples

kubectl delete workshop tap-carvel-workshop
kubectl delete trainingportal tap-workshops 
kubectl delete pod -l deployment=learningcenter-operator -n learningcenter
