#Dockerfile for apps deployment to tomcat-8.0.35

#FROM skcho4docker/tomcat-8.0.35:ver1.0.0 AS tomcat
FROM skcho4docker/tomcat-8.0.35:ver1.0.0
MAINTAINER Sangki Cho
ADD sample.war /usr/local/var/tomcat8/webapps/sample.war
RUN chown tomcat:tomcat /usr/local/var/tomcat8/webapps/sample.war; chmod 664 /usr/local/var/tomcat8/webapps/sample.war
ENV HOME /home/tomcat
USER tomcat
WORKDIR /home/tomcat
EXPOSE 8080
ENTRYPOINT ["/bin/bash","/home/tomcat/start.sh"]
CMD ["exec"]

#FROM scratch
#COPY --from=tomcat / /
#COPY --from=tomcat /etc/ /
#COPY --from=tomcat /bin/ /
#COPY --from=tomcat /home/ /
#ENTRYPOINT ["/bin/bash","/home/tomcat/start.sh"]
#CMD ["exec"]
#LABEL org.mobyproject.config='{"capabilities": ["all"]}'
