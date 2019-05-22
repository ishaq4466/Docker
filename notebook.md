

Hypervisor-based virtual machines-->compute,memory capacity is fixed 
cannot run more workloads on same machines as compared to docker 

1.containers are loosely held isolated environments, 
light weight because they dont need the extra load of hypervisor
they are portable--independent of machine
can run more no of workload on same hardware bcoz of light weight 


2.containers runs directly on the host machine's kernel instead of running on
HOST machine hardware as in VMs

3.Docker containers can run on host machine even if the host machine is a VM

4.Docker engine:client-server model 

docker-client("docker" CLI)<--->REST API<--->server[daemon is  a long running process]("dockerd" cmd)


5. Dockerfile is used to define docker image 




## DOCKER ARCHITECTURE:

docker daemon 
docker client
docker registeries
docker objects: images, container, services


docker daemon(dockerd): Listens API and manages docker image creation

```
docker-machine ip

docker ps -a

docker run -p 4000:80 -d hello-node:1.0
mapping pod 4000 of local host with port 80 of container 
-d: run container in background

docker run -p 4001:80 -d --name container2 $IMG_NAME

docker log container1

docker rmi -f image-name

docker image inspect <image-name>

docker ps -q (Running containers id)

docker rm -f $(docker ps -a -q)


docker inspect $INSTANCE_ID # return a low level description of docker object
```

Getting the instance IP addr 
```
$docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID
```

List all the binding ports
```
$ docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' $INSTANCE_ID

```
"registery collection of repository,repository is collection of built images"

dockerhub.io is a registory
gcr.io
username/repo:tag


## SERVICES:
* In distributed application, different pieces of app are called as services 
* Services are nothing but "containers in production"
* For creating the services in docker we create "docker-compose.yaml"
* services contains container's which are of same image 
* Automatic load balancing,scaling 
* Services allows to deploy Multi-container application 

before deploying the stack you have to init a swarm
stack-->services

*Stack allows to deply application with one or more services interdependent with other*

```
docker swarm init 
docker stack deploy -c docker-compose.yml getstartedlab<stack name>
docker stack ls
docker stack rm getstarted<stackname>
docker stack logs <stackname> -->Getting the logs for a particular stack

docker service ls
docker service logs serviceName<getstarted_web>
docker service ps <service-name> -->shows the task for one or more service

docker swarm leave --force

```
*for deploying stack docker-compose.yaml file name is must*




## DOCKER SWARM:
* a group of machine running docker, joined into a cluster(a grp of machines/nodes)
* In swarm, we have one MANAGER and other node as WORKER 
Only manager-node is authorized to run the cmds while the worker-nodes are 
just to provide capacity.
* The node which run **docker swarm init** becomes manager and workers are joined using the command **docker join --token**
* Swarm participates an ingress routing mesh so that all containers port
point at same port 
```
docker-machine create --driver virtualbox myvm1
docker-machine ls


docker swarm init 
docker node ls
docker stack deploy -c docker-compose.yaml stack1
docker stack ls
docker swarm leave --force
```


## DOCKER STACK
* Stack is a group of inter-related **services** which share some dependencies with each other for proper functionality of entire application
* In production environment we use single stack which can be orchested and scaled together 


			  service1-----		
			 /			  |
			/			  |
stack ---service2---------|----->SINGLE STACK ENTIRE APPLICATION 	
	   		\			  |	
	   		 \			  |
	   		  service3----|

service1:a hello-flask container om port **80**i.e http(displaying container id)

service2:Visualizer showing the different services running on different host
		 running on port 8080

service3:redis db keeping the count for the number of visitor and storing on 
		 persistently on host machine's file system

*80(http),443(https),22(ssh)*

* Functionality of entire application can be defined into a single stack

```
docker swarm init

docker stack deploy -c docker-compose.yaml stack_name
docker stack ls
docker stack logs <stack_name>
docker service ls

docker stack rm <stack_name>
```












