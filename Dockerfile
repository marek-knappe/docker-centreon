From centos:7

RUN yum -y update && yum install -y centos-release-scl http://yum.centreon.com/standard/19.04/el7/stable/noarch/RPMS/centreon-release-19.04-1.el7.centos.noarch.rpm && yum install -y centreon
RUN yum install -y epel-release; \
  yum update -y; \
  yum install -y \
    iproute \
    python-setuptools \
    hostname \
    inotify-tools \
    yum-utils \
    which \
    jq \
    rsync \
    telnet \
    htop \
    atop \
    iotop \
    mtr \
    vim && \
  yum clean all && rm -rf /tmp/yum*; \
  easy_install pip; \
  pip install supervisor
RUN yum install -y openssh-server
RUN /usr/bin/ssh-keygen -A

RUN echo "date.timezone = America/Los_Angeles" > /etc/opt/rh/rh-php71/php.d/php-timezone.ini
ADD files/supervisor.conf /opt/supervisor.conf
ADD files/cbd.initd /etc/init.d/cbd
ADD files/centengine.initd /etc/init.d/centengine
RUN chmod a+x /etc/init.d/cbd /etc/init.d/centengine
ADD files/run.sh /run.sh
VOLUME ["/data"]


EXPOSE 22
EXPOSE 80
EXPOSE 443

CMD ["bash","/run.sh"]

