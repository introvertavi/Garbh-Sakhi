FROM tomcat:10.1.28-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR as ROOT
COPY target/Garbh-Sakhi.war /usr/local/tomcat/webapps/ROOT.war

# Railway provides PORT env variable
ENV PORT=8080

# Make Tomcat listen on Railway port
RUN sed -i "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]
