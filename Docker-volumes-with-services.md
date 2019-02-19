# Docker volumes with services 

1.When using volumes with services, only --mount is supported.

2.When you start a service and define a volume, each service container uses its own local volume. None of the containers can share this data if you use the "local volume driver", but some volume drivers do support "shared storage". Docker for AWS and Docker for Azure both support persistent storage using the Cloudstor plugin

3.Getting hand dirty with volume-service, before getting started we have to 
initialize docker swarm 

```
docker swarm init
```
4.Create the volume for mount source
```
docker volume create /docker/data/myvol2
```

5.Creating the service with 4 replicas of redis image named redisc
```
docker service create -d --replicas=4 --name redisc \
  --mount source=myvol2,target=/app \
  redis:latest
```
6. Getting the service info so that we can SSH into	any one of 
the deployed container  

``` 
#docker service ls
#docker service ps redisc
docker ps 
```
7.SSHing into the container for storing the data into the DB
```
docker exec -it container-name /bin/bash

+++++++++++++++++++++++
Redis cmd:
redis-cli
keys * 
set key1 value1
set key2 value2
keys *
exit

exit
+++++++++++++++++++++++
```

8.Finally removing the service created, and check whether the data 
got persisted or not into our mount-point by "cd to /docker/data/ " 
```
docker service rm service-name
```

9.Most important Point
Removing the service does not remove any volumes created by the service. Volume removal is a separate step.


