FROM tomcat:10.1.28-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/Garbh-Sakhi.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["sh", "-c", "catalina.sh run -Dserver.port=$PORT"]
