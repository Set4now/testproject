FROM centos:7
MAINTAINER sumandeb
RUN yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm -y
RUN yum update -y
RUN yum install salt-master salt-minion salt-cloud salt-ssh salt-api salt-syndic -y
RUN yum install java openssh-server openssh-clients -y
RUN useradd saltadmin && echo "saltadmin" | passwd --stdin saltadmin
RUN yum install sudo -y
RUN echo "saltadmin  ALL=(ALL)    NOPASSWD: ALL" >> /etc/sudoers
RUN echo "master: localhost" >> /etc/salt/minion
RUN echo "id: master" >> /etc/salt/minion
RUN echo "interface: 0.0.0.0" >> /etc/salt/master
VOLUME /srv 
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
EXPOSE 22 4505 4506 8000
CMD /usr/local/bin/run.sh
