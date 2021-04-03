FROM maven:3.6.3-openjdk-15 as BUILDER
ARG VERSION=0.0.1-SNAPSHOT
WORKDIR /build/
COPY pom.xml /build/
COPY src /build/src/

RUN mvn clean package
COPY target/booting-web-${VERSION}.jar target/application.jar

FROM openjdk:15.0.2
WORKDIR /app/

COPY --from=BUILDER /build/target/application.jar /app/
CMD java -jar /app/application.jar