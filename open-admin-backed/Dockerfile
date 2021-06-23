FROM openjdk:8u111-jdk-alpine
RUN set -xe && apk --no-cache add ttf-dejavu fontconfig
ADD target/open-admin-0.0.1-SNAPSHOT.jar open-admin.jar
ENTRYPOINT ["java", "-jar", "/open-admin.jar"]
EXPOSE 8030