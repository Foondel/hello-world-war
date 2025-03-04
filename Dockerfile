FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM tomcat

COPY --from=build /home/app/target/hello*.war /usr/local/tomcat/webapps/
