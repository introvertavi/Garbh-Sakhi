FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:10.1.28-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/Garbh-Sakhi.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
