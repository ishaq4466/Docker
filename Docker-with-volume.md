# Docker with Volumes

1.Docker with "volumes or bind mounts or tmpfs" 
help to persit data on the host machine even if
we delete the container's

2.When you use a bind mount, a file or directory 
on the host machine is mounted into a container. The file or 
directory is referenced by its full or relative path on the 
host machine. By contrast, when you use a volume, a new directory 
is created within Docker’s storage directory on the host machine, and 
Docker manages that directory’s contents.

3.Bind mounts are very performant, but they rely on the host 
machine’s filesystem having a specific directory structure available. 
If you are developing new Docker applications, consider using named 
volumes instead

4.Getting Hands dirty with Volume 

>docker pull redis


>docker run -d -p 6379:6379 -v /docker/data/redis:/data --name redis1 redis:latest

	
This will run a container named "redis1" in backgroud, forwarding the container port 6379 to host port 6379, also it will create a volume in /docker/data(source) nd /data(target) inside container. 


source:The source of the mount. For named volumes, this is the name of the volume. For anonymous volumes, this field is omitted. May be specified as source or src.
(/docker/data/redis-data --> uses absolute path )
destination:The destination takes as its value the path where the file or directory is mounted in the container
```
docker exec -it redis1 /bin/bash

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

cd /docker/data/dump.rdb 
(your redis DB dump)
```
5.Stopping the redis container and removing the image(optionally) 
```
docker ps -a (Stopped and runing containers)
docker stop redis1 
docker remove -rf redis1
docker image ls
docker image rm alpine(base-image)
docker image rm redis(child-image)
(Only untagged image will be there)
```
6.Running the same redis container with the same volume source
```
docker pull redis

docker run -d -p 6379:6379 -v /docker/data/redis:/data --name redis1 redis:latest
```
Again run the redis-cli after ssh into redis container
add some few  more keys-values and remove the container deploy it
and see changes


7.Also the same directory can be backed up on another container

>docker run  -v /docker/redis-data:/backup ubuntu ls /backup

8.Use of --volumes-from option

Mapping our Redis container's volume to an another(Ubuntu) container. The /data directory only exists within our Redis container, however, because of -volumes-from our Ubuntu container can access the data.

>docker run --volumes-from r1 -it ubuntu ls /data



9.Above implementation by first creating a volume and then running  the container 

```
docker run -d -p 6379:6379 -v my-vol:/data --name redis1 redis:latest
docker inspect volume my-vol
```
Again ssh to redis conatiner and do the same as done above

10.Check the data persistency and remove the container
When you "cd" to mount point you will "/var/lib/docker/volume/my-vol/_data/dump.rdb"

Finally for removing volumes

>docker volume rm my-vol
