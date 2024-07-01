# Cleanup
# minikube addons disable ingress &&
# minikube addons disable metrics-server &&
kubectl delete -f secret.yaml &&
kubectl delete -f security.yaml &&
kubectl delete -f ingress.yaml &&
kubectl delete -f service.yaml &&
kubectl delete -f deployment.yaml &&
kubectl delete -f cm.yaml &&
kubectl delete -f storageClass.yaml &&
kubectl delete -f namespace.yaml &&
kubectl label node minikube homework-


# # kubectl delete -f pvc.yaml - PV удаляется вместе с Deployment

# kubectl get pv | grep "Released" --color

