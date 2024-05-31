# Репозиторий для выполнения домашних заданий курса "Инфраструктурная платформа на основе Kubernetes-2024-02" 

### ДЗ №3 Services
https://cdn.otus.ru/media/public/98/6d/%D0%94%D0%97_3___%D0%A1%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%B5_%D0%B2%D0%B7%D0%B0%D0%B8%D0%BC%D0%BE%D0%B4%D0%B5%D0%B8_%D1%81%D1%82%D0%B2%D0%B8%D0%B5_Pod__%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B.pptx-73510-986dc1.pdf
#### httpGet:
Настроен nginx через команду в Deployment манифесте:
```yaml 
          command: ["/bin/sh", "-c"]
          args:
            - echo 'server { listen 8000; location / { root /homework; index index.html;} }' > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
```

#### Настроен Service NodePort:
Слушает на порту 8000

#### Настроен Ingress:
Манифест + Minikube Ingress Controller

Слушает на порту 80

#### Резолюция host:
На своём компьютере добавил запись в C:\Windows\System32\drivers\etc\hosts:
(Под Windows нужно запускать Notepad от имени администратора)
```bash
127.0.0.1 homework.otus
```

#### Проброс туннеля на localhost:
```bash 
minikube tunnel
``` 

#### Рефлексия:
1) Три дня разбирался с httpGet и настройкой nginx в контейнере. 
2) Долго не мог понять, почему не работает Ingress. Оказалось, что нужно было использовать Minikube Tunnel (Вместо Minikube service nginx-service ).
3) Для удобства добавил bash скрипт для запуска всех манифестов. Очень удобно! )))
4) Понял, что нужно больше практики и больше времени на выполнение заданий, хотя кажется что всё просто.