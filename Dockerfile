#Dockerfile for tomcat 
FROM tachibian/centos:ver7.5.1 
MAINTAINER Kazuhiro Tachibana
ADD init.d /etc/init.d/
ADD openjdk-1.8.0_131.tar.gz  /root/
ADD apache-tomcat-8.5.33.tar.gz  /root/
RUN adduser -s /sbin/nologin tomcat;\
    mkdir -p /usr/java;\
    mv /root/openjdk-1.8.0_131 /usr/java;\
    ln -s /usr/java/openjdk-1.8.0_131 /usr/java/jre8;\
    mv /root/apache-tomcat-8.5.33 /usr/local;\
    ln -s /usr/local/apache-tomcat-8.5.33 /usr/local/tomcat;\
    mkdir -p /usr/local/var/tomcat/bin;\
    mv /usr/local/tomcat/bin/setenv.sh /usr/local/var/tomcat/bin;\
    mv /usr/local/tomcat/bin/startup.sh /usr/local/var/tomcat/bin;\
    mv /usr/local/tomcat/bin/shutdown.sh /usr/local/var/tomcat/bin;\
    mv /usr/local/tomcat/conf /usr/local/var/tomcat;\
    mv /usr/local/tomcat/logs /usr/local/var/tomcat;\
    mv /usr/local/tomcat/webapps /usr/local/var/tomcat;\
    mv /usr/local/tomcat/work /usr/local/var/tomcat;\
    mv /usr/local/tomcat/temp /usr/local/var/tomcat;\
    chmod o+rx /usr/local/tomcat/bin;\
    chmod o+rx /usr/local/tomcat/lib;\
    chmod -R o+rx /usr/local/tomcat/bin/*.sh;\
    chmod -R o+r /usr/local/tomcat/bin/*.jar;\
    chmod -R o+r /usr/local/tomcat/lib/*.jar;\
    chown -R tomcat:tomcat /usr/local/var/tomcat;\
    chkconfig --add tomcat;
ENV HOME /root
USER root
WORKDIR /usr/local/tomcat
EXPOSE 8080 8443
ENTRYPOINT ["/sbin/init"] 
