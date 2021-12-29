# FROM gradle:7.1.1-jdk16-hotspot AS build
# COPY --chown=gradle:gradle . /home/doc
# WORKDIR /home/doc
# RUN gradle build --no-daemon


# FROM openjdk:8-jre-slim
#
# EXPOSE 8080
#
# WORKDIR /home/eatl/apps
#
# COPY --from=build /home/eatl/doc/build/libs/*.jar /home/eatl/apps/spring-boot-application.jar

# ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-boot-application.jar"]


# WORKDIR /home/eatl/doc/build/libs
# ENTRYPOINT ["java", "-jar", "/home/eatl/apps/spring-boot-application.jar"]

# ATTEMPT : 1
# FROM gradle:7.1.1-jdk16-hotspot AS build
# RUN mkdir -p /app/source
# # COPY . /app/source
# COPY --chown=gradle:gradle . /app/source
# WORKDIR /app/source
# # COPY --chown=gradle:gradle . /app/source
# # RUN ./gradlew clean package
# # RUN gradle build --no-daemon
# RUN gradle clean package --stacktrace
#
# FROM openjdk:8-jre-slim
# COPY --from=build /app/source/build/libs/*.jar /app/app.jar
# EXPOSE 8085
# ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]

# ATTEMPT : 2
# temp container to build using gradle
# FROM gradle:7.1.1-jdk16-hotspot AS TEMP_BUILD_IMAGE
# ENV APP_HOME=/usr/app/
# WORKDIR $APP_HOME
# COPY build.gradle settings.gradle $APP_HOME
#
# COPY gradle $APP_HOME/gradle
# COPY --chown=gradle:gradle . /home/gradle/src
# USER root
# RUN chown -R gradle /home/gradle/src
#
# RUN gradle build || return 0
# COPY . .
# RUN gradle clean build
#
# # actual container
# FROM openjdk:8-jre-slim
# ENV ARTIFACT_NAME=test-0.0.1-SNAPSHOT.jar
# ENV APP_HOME=/usr/app/
#
# WORKDIR $APP_HOME
# COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/$ARTIFACT_NAME .
#
# EXPOSE 8080
# ENTRYPOINT exec java -jar ${ARTIFACT_NAME}

# ATTEMPT : 3
# FROM gradle:7.1.1-jdk16-hotspot AS TEMP_BUILD_IMAGE
# ENV APP_HOME=/usr/app/
# WORKDIR $APP_HOME
# COPY --chown=gradle:gradle . $APP_HOME
# RUN gradle clean build
#
# # # actual container
# # FROM openjdk:8-jre-slim
# FROM gradle:7.1.1-jdk16-hotspot
# ENV ARTIFACT_NAME=test-0.0.1-SNAPSHOT.jar
# ENV APP_HOME=/usr/app/
#
# WORKDIR $APP_HOME
# COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/$ARTIFACT_NAME .
#
# EXPOSE 8080
# ENTRYPOINT exec java -jar ${ARTIFACT_NAME}

# ATTEMPT : 4
# FROM gradle:7.1.1-jdk16-hotspot
# EXPOSE 8085
# VOLUME /tmp
# ENV ARTIFACT_NAME=test-0.0.1-SNAPSHOT.jar
# COPY ./build/libs/test-0.0.1-SNAPSHOT.jar /home/test-0.0.1-SNAPSHOT.jar
# WORKDIR /home
# # ENTRYPOINT ["java","-jar","test-0.0.1-SNAPSHOT.jar"]
# # ENTRYPOINT exec java -jar ${ARTIFACT_NAME}
# CMD ["java", "-jar", "test-0.0.1-SNAPSHOT.jar"]

# ATTEMPT : 5 (Multi Stage)
FROM gradle:7.1.1-jdk16-hotspot AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM gradle:7.1.1-jdk16-hotspot

EXPOSE 8085

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/test-0.0.1-SNAPSHOT.jar /app/spring-boot-application.jar

CMD ["java", "-jar", "spring-boot-application.jar"]
