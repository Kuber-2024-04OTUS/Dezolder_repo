#!/bin/bash

# Precondition for this script 
# - Docker with clean minikube is installed
# - host resolution: Use PowerShell as Administrator:
#   notepad C:\Windows\System32\drivers\etc\hosts
#   127.0.0.1 homework.otus
# - Start minikube
#   minikube start

# Set context
kubectl config set-context --current --namespace=homework

# Set Node label
kubectl label node minikube homework=true

# Apply homework manifests
kubectl apply -f namespace.yaml &&
kubectl apply -f cm.yaml &&
kubectl apply -f storageClass.yaml &&
kubectl apply -f pvc.yaml 
kubectl apply -f deployment.yaml &&
kubectl apply -f service.yaml &&
kubectl apply -f ingress.yaml &&

# Enable minikube ingress
minikube addons enable ingress &&

# Make tunnel to minikube in detached mode
# Please note, that minikube service nginx-service - doesn't work!
minikube tunnel --cleanup > minikube-tunnel.log 2>&1 &

sleep 20



# Test the service in a second terminal:
curl http://homework.otus/homepage | grep "Welcome to our website!" --color
curl http://homework.otus/conf/key | grep "value" --color


# Expected output:
# Welcome to our website!
# value

# Cleanup
minikube addons disable ingress &&
kubectl delete -f ingress.yaml &&
kubectl delete -f service.yaml &&
kubectl delete -f deployment.yaml &&
kubectl delete -f cm.yaml &&
kubectl delete -f storageClass.yaml &&
kubectl delete -f namespace.yaml &&
kubectl label node minikube homework-


# kubectl delete -f pvc.yaml - PV удаляется вместе с Deployment

kubectl get pv | grep "Released" --color
