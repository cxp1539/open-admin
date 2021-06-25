项目介绍:

Open Admin是基于 Spring Boot + Spring Security + Mybatis + Vue Antd Admin Pro + Mysql开发的框架，致力于为用户生成定制的前后端脚手架框架，系统集成了RBAC, 菜单权限，日志管理，Excel导出, 国际化等常用功能，并且基于gitlab、jenkins、 Docker、 Kubernetes实现了Devops构建流程，使开发专注于业务逻辑。 能够有效降低开发成本，提升开发效率。

Open Admin 的开发借鉴了很多优秀的开源项目，应用案例等等，并将他们纳入项目中，比如前端是基于·iczer / vue-antd-admin·开发，结合自己的思想和开发经验，对框架完成了一次重构。

选择他的理由


- 使用简单

前后端只提供最基础常用的功能，项目搭建起来只需要简单配置，既可使用。

- 页面好看

秉承 Ant Design 的 设计价值观，延用 Ant Design 的 设计原则 , UI简洁美观。

- 前后端分离架构，企业级权限管理

基于JWT Token方案，实现前后端分离，完善的功能权限可控制到按钮粒度级别。

- 企业成熟的解决方案

前后端采用目前最流行的技术框架开发，基础功能完善，可基于Kubernetes + Docker实现Devops构建流程。


项目图

![dcfd08fd26ba34ed14956f00e425b57](https://user-images.githubusercontent.com/45785238/123389408-6d603b80-d5cc-11eb-80be-871abf2eadb7.png)
![ae07a408176b9dca9075a55d568552b](https://user-images.githubusercontent.com/45785238/123389431-74874980-d5cc-11eb-9462-2fc00926337d.png)
![157e3c640f2c121753bd9281c9aafd4](https://user-images.githubusercontent.com/45785238/123389440-76e9a380-d5cc-11eb-9cdb-2182c84fa74a.png)
![d973206d266ec905d53d172dbec6d12](https://user-images.githubusercontent.com/45785238/123389447-78b36700-d5cc-11eb-9010-ef942d8287ba.png)
![微信图片_20210517095553](https://user-images.githubusercontent.com/45785238/123389467-7c46ee00-d5cc-11eb-88c2-2aa134728370.png)
![微信图片_20210517101917](https://user-images.githubusercontent.com/45785238/123389478-7f41de80-d5cc-11eb-81d1-2ed8c09ddfe8.png)


项目体验

http://116.63.145.108:8030/

admin  111111


快速开始

开发环境

	后端

	修改application-env.yml mysql连接信息

	mvn clean package -DskipTests

	cd target

	java -jar open-admin-0.0.1-SNAPSHOT.jar


	前端

	修改.env VUE_APP_API_BASE_URL连接信息

	npm install 

	npm run dev
-------------------------------------

docker artifactory-jcr

docker run --name artifactory-jcr -d -v data_artifactory:/var/opt/jfrog/artifactory -p 8082:8082 -p 8083:8083 docker.bintray.io/jfrog/artifactory-jcr:latest

docker service stop

vim /lib/systemd/system/docker.service 
ExecStart=/usr/bin/dockerd --insecure-registry 192.168.1.100:8082

docker service start

docker login 192.168.1.100:8082 -uadmin -pCxp12345

docker build -t 192.168.1.100:8082/l-docker/open-admin-backed:latest .
docker push 192.168.1.100:8082/l-docker/open-admin-backed:latest

docker build -t 192.168.1.100:8082/l-docker/open-admin-front:latest .
docker push 192.168.1.100:8082/l-docker/open-admin-front:latest

-------------------------------------

测试环境

docker-compose

docker-compose -f open-admin-compose.yaml up -d

docker-compose -f open-admin-compose.yaml down

-------------------------------------

生产环境

k8s


# echo -n 'xxxxxxxxxxxxxxxx' | base64


kubectl create namespace prod

kubectl apply -f k8s-deploy/

kubectl delete -f k8s-deploy/

-----------------------


CI/CD


jenkins

vim /etc/sysconfig/jenkins

-Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true

usermod -a -G docker jenkins
systemctl restart jenkins

mkdir -p $HOME/.kube  
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown 997:993 /var/lib/jenkins/.kube/config



docker gitlab

docker run -d  -p 443:443 -p 80:80 -p 2222:22 --name gitlab --restart always -v /home/gitlab/config:/etc/gitlab -v /home/gitlab/logs:/var/log/gitlab -v /home/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce


vim /home/gitlab/config/gitlab.rb

external_url 'http://www.docker.com'
 
# 配置ssh协议所使用的访问地址和端口
gitlab_rails['gitlab_ssh_host'] = 'www.docker.com'
gitlab_rails['gitlab_shell_ssh_port'] = 2222 # 此端口是run时22端口映射的2222端口


docker restart gitlab


-----------------------

运维监控


kubectl apply -f heapster/

kubectl delete -f heapster/

http://192.168.1.100:30558/
