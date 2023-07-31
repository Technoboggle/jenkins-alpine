#!/usr/bin/env sh

owd="$(pwd)"
cd "$(dirname "$0")" || exit

jenkins_ver="2.416"
alpine_ver="3.18.2"

# Setting File permissions
home_dir="$(pwd)/jenkins-home"
cert_dir="$(pwd)/jenkins-docker-certs"

if [ -d "$home_dir" ]; then
  echo "rebuilding home dir: $home_dir"
  rm -rf "$home_dir"
  mkdir -p "$home_dir"
else
  mkdir -p "$home_dir"
fi
xattr -c .git
xattr -c .gitignore
xattr -c .dockerignore
xattr -c ./*
chmod 0666 ./*
chmod 0777 ./*.sh
chmod 0777 "$cert_dir"
chmod 0777 "$home_dir"

current_builder=$(docker buildx ls | grep -i '\*' | head -n1 | awk '{print $1;}')

docker buildx create --name tb_builder --use --bootstrap

docker login -u="technoboggle" -p="dckr_pat_FhwkY2NiSssfRBW2sJP6zfkXsjo"

#docker network create jenkins
docker buildx build -f Dockerfile --platform linux/amd64,linux/386 \
  -t technoboggle/jenkins-alpine:"${jenkins_ver}-${alpine_ver}" \
  --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
  --build-arg VCS_REF="$(git rev-parse --verify HEAD)" \
  --progress=plain \
  --no-cache \
  --push .
#--progress=plain

docker run -it -d -p 8080:8080 -p 50000:50000 \
  --restart=on-failure \
  -v jenkins-home:/var/jenkins-home \
  -v jenkins-docker-certs:/certs/client:ro \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --name myjenkins \
  technoboggle/jenkins-alpine:"$jenkins_ver-$alpine_ver"
docker container stop -t 10 myjenkins

docker buildx use "${current_builder}"
docker buildx rm tb_builder

cd "$owd" || exit
