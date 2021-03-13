# jenkins-alpine
a docker image base on alpine with jenkins

# build image
```
docker build -f Dockerfile -t technoboggle/jenkins-alpine:2.277.1 .
docker run -it --rm -v $(pwd):/app -p 3306:3306 technoboggle/jenkins-alpine:2.277.1
```

# Usage
```
docker run -it --name mysql -p 3306:3306 -v $(pwd):/app -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 wangxian/alpine-mysql
```

It will create a new db, and set mysql root password(default is 111111)

#####################################################################
# use the following commands to build image and upload to dockerhub
```
# Setting File permissions
xattr -c .git
xattr -c .gitignore
xattr -c .dockerignore
xattr -c *
chmod 0666 *
chmod 0777 .git
chmod 0777 *.sh





#chmod 0755 scripts/start.sh
docker network create jenkins
docker build -f Dockerfile -t technoboggle/jenkins-alpine:2.277.1 .
docker run --name jenkins-blueocean --rm --detach --network jenkins --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --publish 8080:8080 --publish 50000:50000 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro technoboggle/jenkins-alpine:2.277.1
docker tag technoboggle/jenkins-alpine:2.277.1 technoboggle/jenkins-alpine:latest
docker login
docker push technoboggle/jenkins-alpine:2.277.1
docker push technoboggle/jenkins-alpine:latest
docker container stop -t 10 mysql
```
