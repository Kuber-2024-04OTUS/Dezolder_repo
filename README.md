# Репозиторий для выполнения домашних заданий курса "Инфраструктурная платформа на основе Kubernetes-2024-02" 

ДЗ: [Скачать](https://cdn.otus.ru/media/public/54/39/%D0%94%D0%97_1___%D0%97%D0%BD%D0%B0%D0%BA%D0%BE%D0%BC%D1%81%D1%82%D0%B2%D0%BE_%D1%81_%D1%80%D0%B5%D1%88%D0%B5%D0%BD%D0%B8%D1%8F%D0%BC%D0%B8_%D0%B4%D0%BB%D1%8F_%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%D0%B0_%D0%BB%D0%BE%D0%BA%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B3%D0%BE_Kubernetes_%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B0__%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%BF%D0%B5%D1%80%D0%B2%D0%BE%D0%B3%D0%BE_pod.pptx-73510-5439ec.pdf "Скачать")

---
### [Установка Docker](https://docs.docker.com/engine/install/)

У меня версия 29.0.0:

![alt text2](./pic/Pasted%20image%2020240505115628.png)

---
### [Установка Minikube](https://minikube.sigs.k8s.io/docs/start/).

 
Установить Minikube (с правами администратора powerShell):
```pwershell
choco install minikube
```
Если надо обновить то (с правами администратора powerShell):
```pwershell
choco upgrade minikube
```

У меня версия v1.33.0:
<!-- ![[Pasted image 20240504164312.png]] -->

![pic2](./pic/Pasted%20image%2020240504164312.png)



---
### [Установка Kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)


```powershell
choco install kubernetes-cli
```

#### Авто-дополнение для kubectl:
Для включения авто дополнения (в git-bash):

> В этой документации нету явного примера для установки под Windows:
>
> ![Pasted image 20240504183931.png](/pic/Pasted%20image%2020240504183931.png)
> 
>
>Но как-то у меня оно заработало. Трудно будет повторить на новой системе, но можно попробовать так:
>
> ```bash
> echo 'source <(kubectl completion bash)' >>~/.bashrc
> echo 'alias k=kubectl' >>~/.bashrc
> echo 'complete -F __start_kubectl k' >>~/.bashrc
> ```
>
 ![![Pasted image 20240504185941.png]](./pic/Pasted%20image%2020240504185941.png)
<!-- ![[Pasted image 20240504185941.png]] -->

> Server и Client в рамках одной минорной версии! Можно пользоваться )


---

### Запуск HyperV

Тоже пробовал, всё заработало на hyperv
```bash
minikube start --driver=hyperv
```
Немного удобнее чем Docker Desktop в плане проброски портов, но появляются глюки с доступом в интернет при входе в Windows, и некоторые приложения на компе остаются в оффлайн режиме. Через минуту интернет появляется, но всё равно это неудобно. В общем, остальные задания буду делать только на Docker Desktop container run-time.

---

### [Установка K9s](https://k9scli.io/)

![![Pasted image 20240504202555.png]](/pic/Pasted%20image%2020240504202555.png)
<!-- ![[Pasted image 20240504202555.png]] -->
```powershell
choco install k9s
```

---

### Начало Работы

#### Клон репо в локальный бренч kubernetes-intro:
```gitbash
git clone https://github.com/Kuber-2024-04OTUS/Dezolder_repo.git
cd Dezoler_repo/
code .
git branch kubernetes-intro
git switch kubernetes-intro
```

Создаём папку `kubernetes-intro`:
```gitbash
mkdir kubernetes-intro
```

> Пользуюсь git-bash по умолчанию в VS Code.
> К нему добавил расширение GitHub CLI:  https://github.com/cli/cli#installation
```gitbash
winget install --id GitHub.cli
winget upgrade --id GitHub.cli
```
> К нему ещё добавил расширение gh-copilot: > https://github.com/github/gh-copilot
```gitbash
gh extension install github/gh-copilot --force 
```
> И к этому расширению добавил алиасы:
```gitbash
echo 'eval "$(gh copilot alias -- bash)"' >> ~/.bashrc
```
> Очень удобно спрашивать копилот примерно так: `ghcs print "Hello world"`
>
Мой ~/.bashrc выглядит так:

![![Pasted image 20240504195050.png]](/pic/Pasted%20image%2020240504195050.png)
<!-- ![[Pasted image 20240504195050.png]] -->

#### Установка Kubernetes extenstion for VS Code

![![Pasted image 20240504195846.png]](/pic/Pasted%20image%2020240504195846.png)
<!-- ![[Pasted image 20240504195846.png]] -->

Это расширение помогает создавать манифесты Kubernetes

#### Манифест Namespace

Создаём файл `namespace.yaml`:
![![Pasted image 20240504200651.png]](/pic/Pasted%20image%2020240504200651.png)
<!-- ![[Pasted image 20240504200651.png]] -->
> Почему-то шаблон для `Namespace` не предлагается :(
#### Манифест Pod

Создаём файл `pod.yaml`:

_Расширение подсказывает нужный шаблон:_ 

![![Pasted image 20240504201807.png]](/pic/Pasted%20image%2020240504201807.png)
![![Pasted image 20240504202223.png]](/pic/Pasted%20image%2020240504202223.png)
<!-- ![[Pasted image 20240504201807.png]] -->
<!-- ![[Pasted image 20240504202223.png]] -->

От Yaml файлов рябит в глазах, но если долго смотреть то всё проясняется )

В конце-концов, получается то что нужно:
![![Pasted image 20240504202849.png]](/pic/Pasted%20image%2020240504202849.png)
<!-- ![[Pasted image 20240504202849.png]] -->

#### Применяем манифесты

```gitbash
k apply -f namespace.yaml -f pod.yaml
```

Запускаем K9s в отдельном терминале:
```powershell
k9s
```
![![Pasted image 20240504203538.png]](/pic/Pasted%20image%2020240504203538.png)
<!-- ![[Pasted image 20240504203538.png]] -->

В логах основного контейнера наблюдаем: `Welcome to our website!`

Основное задание выполнено, осталось сделать PR

```gitbash
git push origin kubernetes-itro
```

В веб интерфейсе Git Hub нажимаем PR...

---

## Рефлексия

1) Нужно почитать Kubernetes Documentation: что писать в аргументах `apiVerion`, про `emptyDir`, структура манифестов...
2) Очень помогает Copilot
3) Настроить WSL для управления кубернетисом хост машины не удалось: нужно указать токен, но не нашёл где его взять.
4) Почитать доку к K9s. Как им управлять...

---
