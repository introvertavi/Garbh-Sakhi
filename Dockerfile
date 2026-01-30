FROM tomcat:10.1.28-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR as ROOT
COPY target/Garbh-Sakhi.war /usr/local/tomcat/webapps/ROOT.war

# Expose Railway port (informational only)
EXPOSE 8080

# Start Tomcat using Railway PORT at runtime
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"$PORT\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
