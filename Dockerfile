FROM jenkins/jenkins:2.386-alpine-jdk17
LABEL org.opencontainers.image.vendor="Jenkins project" \
org.opencontainers.image.title="Official Jenkins Docker image" \
org.opencontainers.image.description="The Jenkins Continuous Integration and Delivery server" \
org.opencontainers.image.version="2.386" \
org.opencontainers.image.url="https://www.jenkins.io/" \
org.opencontainers.image.source="https://github.com/jenkinsci/docker" \
org.opencontainers.image.licenses="MIT" \
net.technoboggle.buildDate=$buildDate
USER root
#RUN apt-get update && apt-get install -y apt-transport-https \
#       ca-certificates curl gnupg2 \
#       software-properties-common
#RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
#RUN apt-key fingerprint 0EBFCD88
#RUN add-apt-repository \
#       "deb [arch=amd64] https://download.docker.com/linux/debian \
#       $(lsb_release -cs) stable"
#RUN apt-get update && apt-get install -y docker-ce-cli
#USER jenkins
#RUN jenkins-plugin-cli --plugins blueocean:1.24.3




RUN apt-get update; \
  apk add --no-cache --update \
#  apt-transport-https \
  ca-certificates \
  curl \
  tar \
  xz; \
#  gnupg2 

#RUN apt-get update && apt-get install -y apt-transport-https \
#       ca-certificates curl gnupg2 \
#       software-properties-common


  apk add --no-cache --update gnupg docker-cli
#RUN apt-key fingerprint 0EBFCD88
#RUN add-apt-repository \
#       "deb [arch=amd64] https://download.docker.com/linux/debian \
#       $(lsb_release -cs) stable"
#RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins blueocean:1.24.4
