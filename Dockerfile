FROM jenkins/jenkins:2.277.1-lts-alpine
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




RUN apk add --no-cache --update \
#  apt-transport-https \
  ca-certificates \
  curl \
  tar \
  xz 
#  gnupg2 

#RUN apt-get update && apt-get install -y apt-transport-https \
#       ca-certificates curl gnupg2 \
#       software-properties-common



RUN apk add --no-cache --update gnupg docker-cli
#RUN apt-key fingerprint 0EBFCD88
#RUN add-apt-repository \
#       "deb [arch=amd64] https://download.docker.com/linux/debian \
#       $(lsb_release -cs) stable"
#RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins blueocean:1.24.4
