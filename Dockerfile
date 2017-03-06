FROM jenkins

ENV DEBIAN_FRONTEND noninteractive
USER root

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh


RUN echo 'DOCKER_OPTS="-H :2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
RUN gpasswd -a jenkins docker

VOLUME /var/lib/docker

EXPOSE 2375
COPY start.sh /start.sh
RUN chmod +x /start/sh

ENTRYPOINT sh /start.sh
