FROM adoptopenjdk/openjdk11:x86_64-alpine-jdk-11.0.11_9-slim
ENV CONF=/opt/config
ENV HOME_DIR=/opt/jfrog/ba/
ARG JAR_LOCATION
ENV JAR_LOCATION=$JAR_LOCATION

RUN apk add --no-cache bash && \
    bash -c 'mkdir -p ${HOME_DIR}{logs,config,tmp}' && \
    adduser --home ${HOME_DIR} -D playground-user && \
    chown -R playground-user:playground-user ${HOME_DIR} ;

COPY "${JAR_LOCATION}/spring-boot-playground-0.0.1-SNAPSHOT.jar" ${HOME_DIR}'playground.jar'

EXPOSE 8080 8080

USER playground-user

WORKDIR ${HOME_DIR}
ENTRYPOINT ["java" ,"-jar", "playground.jar"]
#ENTRYPOINT ["/bin/sh"]
