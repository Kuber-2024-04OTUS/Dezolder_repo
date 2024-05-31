#!/bin/bash

# Precondition for this script - Docker with clean minikube is installed

# Start minikube
# minikube start
kubectl config set-context --current --namespace=homework
# Set Node label
kubectl label node minikube homework=true

# Apply homework manifests
kubectl apply -f namespace.yaml &&
kubectl apply -f deployment.yaml &&
kubectl apply -f service.yaml &&
kubectl apply -f ingress.yaml &&

# Enable minikube ingress
minikube addons enable ingress &&

# sleep 30

# Make tunnel to minikube in detached mode
# Please note, that minikube service nginx-service - doesn't work!
minikube tunnel --cleanup > minikube-tunnel.log 2>&1 &

sleep 20

# host resolution
# Use PowerShell as Administrator
# notepad C:\Windows\System32\drivers\etc\hosts
# 127.0.0.1 homework.otus

# Test the service in a second terminal:
curl http://homework.otus/homepage | grep "Welcome to our website!" --color

# Expected output:
# Welcome to our website!

# Cleanup
minikube addons disable ingress &&
kubectl delete -f ingress.yaml &&
kubectl delete -f service.yaml &&
kubectl delete -f deployment.yaml &&
kubectl delete -f namespace.yaml