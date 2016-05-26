FROM centos:7
MAINTAINER Joeri van Dooren

RUN yum clean all -y && yum -y install epel-release && yum -y install nginx git openssl curl supervisor ccrypt && yum clean all -y && mkdir -p /var/www && mkdir -p /var/www/letsencrypt

# web content
ADD html /var/www
ADD nginx.conf /
ADD ssl /tmp/ssl
ADD run_letsencrypt.sh /
ADD README /
ADD GOTO_var_ssl /

ADD letsencrypt.sh /
RUN cd /root/ && git clone https://github.com/lukas2511/letsencrypt.sh.git && chmod a+rx /letsencrypt.sh && chmod a+rwxt /var/www && chmod -R a+rwxt /var/www/* && chmod a+rwx /root/letsencrypt.sh && chmod a+rx /run_letsencrypt.sh && chmod ugo+r /nginx.conf

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
