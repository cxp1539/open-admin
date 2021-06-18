FROM azul/zulu-openjdk-alpine
ADD target/open-admin-0.0.1-SNAPSHOT.jar open-admin.jar
ENTRYPOINT ["java", "-jar", "/open-admin.jar"]
EXPOSE 8030