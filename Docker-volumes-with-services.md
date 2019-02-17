Docker volumes with services 

1.When using volumes with services, only --mount is supported.

2.When you start a service and define a volume, each service container uses its own local volume. None of the containers can share this data if you use the "local volume driver", but some volume drivers do support "shared storage". Docker for AWS and Docker for Azure both support persistent storage using the Cloudstor plugin

docker swarm init


docker service create -d --replicas=4 --name redisc \
  --mount source=myvol2,target=/app \
  redis:latest


docker service ls

docker service ps redisc

docker ps 

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


docker service rm service-name



Removing the service does not remove any volumes created by the service. Volume removal is a separate step.


