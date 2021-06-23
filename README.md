项目背景:

在当前互联网环境下，往往会遇到一些需要快速成型的项目，这些项目不可或缺的都离不开后台管理系统，这些管理系统通常都需要包含登录，RABC权限，日志，用户管理，Excel导出等通用的功能，前后端开发起来少则一周，多则几周。

我们应该把更多的精力释放出来，更多的投入到业务中去，避免去开发重复性功能，去节约一些时间和成本，利用这些成本和时间去做更多有意义的事情。

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