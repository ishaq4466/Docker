# Docker with Bind Mount

1.Bind mounts have limited functionality compared to volumes. When you use a bind mount, a file or directory on the host machine is mounted into a container. The file or directory is referenced by its full or relative path on the host machine. By contrast, when you use a volume, a new directory is created within Docker’s storage directory on the host machine, and Docker manages that directory’s contents.

2.Bind mounts are very performant, but they rely on the host machine’s filesystem having a specific directory structure available

If you use --mount to bind-mount a file or directory that does not yet exist on the Docker host, Docker does not automatically create it for you, but generates an error.

3.Use case for Bind-Mount
Consider a case where you have a directory source and that when you build the source code, the artifacts are saved into another directory, source/target/. You want the artifacts to be available to the container at /app/, and you want the container to get access to a new build each time you build the source on your development host. Use the following command to bind-mount the target/ directory into your container at /app/. Run the command from within the source directory.

4.Getting Hands Dirty with Bind-Mounts

Pulling the redis image
```
docker pull redis 
```

Making the redis-data directory for binding the mount point
```
mkdir redis-data
```

Running the container with the bind-mount 
```
docker run -d  --name redis1 --mount type=bind,source="$(pwd)"/redis-data,target=/data redis:latest
```

Inspecting the container for getting the mount-point info. 
```
docker inspect redis1 | grep -i 'data'
```

Entering into the "redis1" container and adding some key value pairs 
into the db
```
docker exec -it redis1 /bin/bash

+++++++++++++++++++++++
Redis cmds:
redis-cli
keys * 
set key1 value1
set key2 value2
keys *
exit

exit
+++++++++++++++++++++++
```

Stopping and removing the container 
```
docker stop redis1

docker rm -f redis1
```
Finally checking whether the data get persisted on our bind-mount
or not
```
cd redis-data/dump.rdb
#ls -lt redis-data/dump.rdb
```

5.Important point if you use --mount to bind-mount a file or directory that does not yet exist on the Docker host, Docker does not automatically create it for you, but generates an error.

