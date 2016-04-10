FROM centos:7
MAINTAINER Joeri van Dooren

RUN yum clean all -y && yum -y install epel-release && yum -y install nginx git openssl curl supervisor ccrypt && yum clean all -y

RUN mkdir -p /var/www
RUN mkdir -p /var/www/letsencrypt

# web content
ADD html /var/www

ADD nginx.conf /

RUN chmod ugo+r /nginx.conf

RUN cd /root/ && git clone https://github.com/lukas2511/letsencrypt.sh.git

ADD ssl /tmp/ssl

ADD run_letsencrypt.sh /
RUN chmod a+rx /run_letsencrypt.sh

ADD README /
RUN chmod a+r /README

ADD GOTO_var_ssl /

ADD letsencrypt.sh /
RUN chmod a+rx /letsencrypt.sh

RUN chmod a+rwxt /var/www
RUN chmod -R a+rwxt /var/www/*

ADD supervisord.conf /tmp/supervisord.conf

WORKDIR /var/ssl

USER 997
EXPOSE 8080
CMD ["/usr/bin/supervisord", "-n", "-c", "/tmp/supervisord.conf"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Platform for automating ssl certs" \
      io.k8s.display-name="letsencrypt centos7 epel" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="lestencrypt" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
