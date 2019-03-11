#
# Build stage
#
FROM maven:3.6-jdk-11 AS build
WORKDIR /tmp
RUN wget https://github.com/EBISPOT/zooma/archive/zooma2-2.1.10.tar.gz && \
    tar -xvzf zooma2-2.1.10.tar.gz
WORKDIR /tmp/zooma-zooma2-2.1.10
COPY zooma-core.edited.pom.xml zooma-core/pom.xml
RUN mvn dependency:get -Dartifact=javax.annotation:javax.annotation-api:1.3:jar && \
    mvn clean package

FROM tomcat:9.0-jre11
COPY --from=build /tmp/zooma-zooma2-2.1.10/zooma-ui/target/zooma.war /usr/local/tomcat  
EXPOSE 8080
ENTRYPOINT ["catalina.sh","run"]