FROM tomcat:10.1.28-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR
COPY target/Garbh-Sakhi.war /usr/local/tomcat/webapps/ROOT.war

# Railway exposes PORT dynamically
EXPOSE 8080

CMD ["sh", "-c", "\
sed -i 's/port=\"[0-9]*\" protocol=\"org.apache.coyote.http11.Http11NioProtocol\"/port=\"'$PORT'\" address=\"0.0.0.0\" protocol=\"org.apache.coyote.http11.Http11NioProtocol\"/' /usr/local/tomcat/conf/server.xml \
&& catalina.sh run"]
