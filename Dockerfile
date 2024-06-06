# FROM openjdk:8
# EXPOSE 8888
# ADD /target/ApiGateway-0.0.1-SNAPSHOT.jar gateway-service.jar
# ENTRYPOINT ["java","-jar" , "gateway-service.jar"]

#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -q -Dmaven.test.skip -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:8
COPY --from=build /home/app/target/api-gateway-0.0.1-SNAPSHOT.jar /usr/local/lib/api-gateway.jar
EXPOSE 8585
ENTRYPOINT ["java","-jar","/usr/local/lib/api-gateway.jar"]