#!/bin/bash

# Precondition for this script 
# - Docker with clean minikube is installed
# - host resolution: Use PowerShell as Administrator:
#   notepad C:\Windows\System32\drivers\etc\hosts
#   127.0.0.1 homework.otus
# - Start minikube
#   minikube start
# - Enable minikube ingress
# minikube addons enable ingress &&
# - Enable minikube metrics-server
# minikube addons enable metrics-server

# Set context
kubectl config set-context --current --namespace=homework

# Set Node label
kubectl label node minikube homework=true

# Apply homework manifests
kubectl apply -f namespace.yaml &&
kubectl apply -f security.yaml &&
kubectl apply -f secret.yaml &&
kubectl apply -f cm.yaml &&
kubectl apply -f storageClass.yaml &&
kubectl apply -f pvc.yaml 
kubectl apply -f deployment.yaml &&
kubectl apply -f service.yaml &&
kubectl apply -f ingress.yaml &&


# Make tunnel to minikube in detached mode
# Please note, that minikube service nginx-service - doesn't work!
minikube tunnel --cleanup > minikube-tunnel.log 2>&1 &

sleep 20



# Test the service in a second terminal:
curl http://homework.otus/homepage | grep "Welcome to our website!" --color
curl http://homework.otus/conf/key | grep "value" --color
curl http://homework.otus/metrics.html


# Expected output:
# Welcome to our website!
# value




# Получите имя секрета для Service Account 'cd'
SECRET_NAME=$(kubectl get serviceaccount cd -n homework -o jsonpath='{.secrets[0].name}')

# Получите токен и CA из секрета
TOKEN=$(kubectl get secret $SECRET_NAME -n homework -o jsonpath='{.data.token}' | base64 --decode)
CA=$(kubectl get secret $SECRET_NAME -n homework -o jsonpath='{.data.ca\.crt}' )

# Получите адрес сервера Kubernetes
SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')

# Сохранить token в файл:
echo $TOKEN > token

# Создайте файл cd.kubeconfig
cat > cd.kubeconfig <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: 
      $CA
    server: $SERVER
  name: minikube
contexts:
- context:
    cluster: minikube
    namespace: homework
    user: cd
  name: cd-context
current-context: cd-context
kind: Config
preferences: {}
users:
- name: cd
  user:
    token:  
      $TOKEN
EOF

# Проверить, что получилось:
kubectl --kubeconfig=cd.kubeconfig get pods


# Cleanup:
# bash bash-cleanup.sh