## 项目介绍

Open Admin是基于 Spring Boot + Spring Security + Mybatis + Vue Antd Admin Pro + Mysql开发的框架，致力于为用户生成定制的前后端脚手架框架，系统集成了同步菜单、异步菜单、RBAC、 菜单权限、日志管理、Excel导出、国际化等常用功能，并且基于Gitlab、Jenkins、 Docker、 Kubernetes实现了Devops构建流程，使开发专注于业务逻辑。 能够有效降低开发成本，提升开发效率。

Open Admin 的开发借鉴了很多优秀的开源项目，应用案例等等，并将他们纳入项目中，比如前端是基于`iczer / vue-antd-admin`开发，结合自己的思想和开发经验，对框架完成了一次重构。

## 选择它的理由


- 使用简单

前后端只提供最基础常用的功能，项目搭建起来只需要简单配置，既可使用。

- 页面好看

秉承 Ant Design 的 设计价值观，延用 Ant Design 的设计原则 , UI简洁美观。

- 前后端分离架构，企业级权限管理

基于 JWT Token 方案，实现前后端分离，完善的功能权限可控制到按钮粒度级别。

- 企业成熟的解决方案

前后端采用目前最流行的技术框架开发，基础功能完善，可基于Kubernetes + Docker + Jenkins 实现 Devops 构建流程。


## 项目截图

![dcfd08fd26ba34ed14956f00e425b57](https://user-images.githubusercontent.com/45785238/123389408-6d603b80-d5cc-11eb-80be-871abf2eadb7.png)
![ae07a408176b9dca9075a55d568552b](https://user-images.githubusercontent.com/45785238/123389431-74874980-d5cc-11eb-9462-2fc00926337d.png)
![157e3c640f2c121753bd9281c9aafd4](https://user-images.githubusercontent.com/45785238/123389440-76e9a380-d5cc-11eb-9cdb-2182c84fa74a.png)
![d973206d266ec905d53d172dbec6d12](https://user-images.githubusercontent.com/45785238/123389447-78b36700-d5cc-11eb-9010-ef942d8287ba.png)
![20210517095553d53d172dbec6d12ac](https://user-images.githubusercontent.com/45785238/123389467-7c46ee00-d5cc-11eb-88c2-2aa134728370.png)
![20210517101917d53d172dbec6d12bd](https://user-images.githubusercontent.com/45785238/123389478-7f41de80-d5cc-11eb-81d1-2ed8c09ddfe8.png)


## 项目体验

http://116.63.145.108:8030/

admin/111111

## 快速开始

open-admin 集成了 同步菜单、异步菜单，默认使用异步菜单，菜单数据由后端接口提供，如果系统不需要自定义菜单权限，可以改成同步菜单，菜单由前端配置。 修改方式 
编辑 open-admin-front main.js 文件 将 `initRouter` 方法 第一个参数 改为 true 即可

### 本地开发

#### open-admin-backed

修改 application-env.yml mysql 数据库信息

```bash
mvn clean package -DskipTests
cd target
java -jar open-admin-0.0.1-SNAPSHOT.jar
```

#### open-admin-front

修改 .env VUE_APP_API_BASE_URL api 接口地址

```bash
npm install 
npm run dev
```

### docker 私有镜像

open-admin 采用 `artifactory-jcr` 搭建私有仓库镜像，以下是artifactory-jcr docker方式安装命令
```bash
docker run --name artifactory-jcr -d -v data_artifactory:/var/opt/jfrog/artifactory -p 8082:8082 -p 8083:8083 docker.bintray.io/jfrog/artifactory-jcr:latest
vim /lib/systemd/system/docker.service 
ExecStart=/usr/bin/dockerd --insecure-registry 192.168.1.100:8082
docker service start

```

`artifactory-jcr` 启动以后，分别切换到 open-admin-backed、 open-admin-front项目下 基于 `Dockerfile` 打包成镜像，进而推送到私有镜像上

```bash
docker build -t 192.168.1.100:8082/l-docker/open-admin-backed:latest .
docker push 192.168.1.100:8082/l-docker/open-admin-backed:latest
docker build -t 192.168.1.100:8082/l-docker/open-admin-front:latest .
docker push 192.168.1.100:8082/l-docker/open-admin-front:latest
```

### 测试环境

测试环境可以使用 `docker-compose` 方式部署，mysql初始化命令在 docker-mysql 目录下，docker-compose.yaml 在 docker-compose 目录下，切换到该目录下 修改open-admin-compose.yaml 文件中 mysql配置目录 运行以下命令即可

```bash
docker-compose -f open-admin-compose.yaml up -d
docker-compose -f open-admin-compose.yaml down
```


### 生产环境

生产环境建议使用 `kubernetes` 方式部署，mysql 密码使用kubernetes secret 方式保存，可以通过 `echo -n 'xxxxxxxxxxxxxxxx' | base64` 生成， kubernetes.yaml 在 kubernetes 目录下，切换到该目录下 运行以下命令即可

```bash
# 创建生产环境命令空间
kubectl create namespace prod
kubectl apply -f k8s-deploy/
kubectl delete -f k8s-deploy/
```

## CI/CD

CI/CD 通过 jenkins，gitlab 方式构建，jenkins pipline 配置信息 在 jenkins-pipline 目录下，可以基于该配置进行自定义扩展， 以下是jenkins, gitlab安装方式和配置信息

```bash
# jenkins 使用安装包安装， 配置信息需要做如下修改
vim /etc/sysconfig/jenkins
-Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true

usermod -a -G docker jenkins
systemctl restart jenkins

mkdir -p $HOME/.kube  
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown 997:993 /var/lib/jenkins/.kube/config
```

```bash
# docker方式安装gitlab
docker run -d  -p 443:443 -p 80:80 -p 2222:22 --name gitlab --restart always -v /home/gitlab/config:/etc/gitlab -v /home/gitlab/logs:/var/log/gitlab -v /home/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce

vim /home/gitlab/config/gitlab.rb
external_url 'http://www.gitlab.com'
 
# 配置ssh协议所使用的访问地址和端口
gitlab_rails['gitlab_ssh_host'] = 'www.gitlab.com' # 此域名改成自己的域名
gitlab_rails['gitlab_shell_ssh_port'] = 2222 # 此端口是run时22端口映射的2222端口

docker restart gitlab
```

## 运维监控

Kubernetes Dashboard 提供了在web页面上管理K8S，运维监控可以通过 Heapster+InfluxDB+Grafana 搭建监控平台，监控平台 yml 配置文件 heapster 目录下，切换到该目录下，运行以下命令 通过浏览器 `http://ip:30558` 访问即可

```bash
kubectl apply -f heapster/
kubectl delete -f heapster/
```

## License

[MIT](https://github.com/cxp1539/open-admin/blob/main/LICENSE)

