ARG JDK_IMAGE=eclipse-temurin:17.0.3_7-jdk-centos7

FROM ${JDK_IMAGE} as builder-jdk

FROM centos:7 as builder

COPY installer installer

COPY --from=builder-jdk /opt/java/openjdk /usr/java
COPY response.ini .

RUN installer/proinst -b response.ini -l response.log

RUN cat response.log
RUN echo "Docker Container Image for Dev PAS for OpenEdge 12.8.0 as of `date`" > /psc/dlc/image-version

FROM centos:7

# Add a non root user
RUN groupadd pscadmin &&\
    useradd -g pscadmin pscadmin

# Copy dlc, java and wrk
COPY --from=builder --chown=pscadmin:pscadmin /usr/java /usr/java
COPY --from=builder --chown=pscadmin:pscadmin /psc/dlc /psc/dlc
COPY --from=builder --chown=pscadmin:pscadmin /psc/wrk /psc/wrk

# Copy init/run scripts
COPY scripts/* /psc/wrk/

# Restrict permissions
# Read and execute only
RUN chmod 0555 /psc/wrk/initcmd.sh 

# From now on run as abldojo user
USER pscadmin

ENV JAVA_HOME=/usr/java \
    PATH=/psc/dlc:/psc/dlc/bin:/psc/dlc/ant/bin:$PATH \
    WRKDIR=/psc/wrk/ \
    DLC=/psc/dlc/

WORKDIR /psc/wrk/

CMD [ "/psc/wrk/initcmd.sh" ]