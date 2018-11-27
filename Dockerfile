FROM jenkins/jnlp-slave:alpine

USER root
RUN apk add --no-cache \
ca-certificates \
curl \
openssl \
python \
py-pip \
py-yaml \
alpine-sdk

ENV DOCKER_BUCKET download.docker.com
ENV DOCKER_VERSION 18.09.0

RUN set -x \
&& curl -fSL "https://${DOCKER_BUCKET}/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
&& tar -xzvf docker.tgz \
&& mv docker/* /usr/local/bin/ \
&& rmdir docker \
&& rm docker.tgz \
&& docker -v

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
