#
#  author  : Jeong Han Lee
#  email   : jeonghan.lee@gmail.com

## BuildEnv docker image size : 672MB
FROM alpine:3.12

LABEL maintainer="Jeong Han Lee <jeonghan.lee@gmail.com>"

ARG BUILD_DATE
ARG BUILD_VERSION
ARG ES_PORT_REST=9200
ARG ES_PORT_NODES=9300
ARG TZ=America/Los_Angeles


LABEL maintainer="Jeong Han Lee <jeonghan.lee@gmail.com>"
# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="jeonghanlee/es4epics"
LABEL org.label-schema.description="EPICS Elasticsearch EPICS middleware Docker Image"
LABEL org.label-schema.url="https://github.com/jeonghanlee/es4epics"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run --network=host --detach --rm --name=es4epics jeonghanlee/es4epics:latest"

ENV ELASTIC_CONTAINER=true
ENV ES_PORT_REST ${ES_PORT_REST}
ENV ES_PORT_NODES ${ES_PORT_NODES}

ENV TZ ${TZ}

RUN apk add --no-cache bash elasticsearch elasticsearch-lang-painless tzdata

ENV ES_PATH="/usr/share/java/elasticsearch"
ENV ES_PATH_CONF="/etc/elasticsearch"
ENV ES_TMPDIR="${ES_PATH_CONF}/tmp"
ENV ES_PATH_LOG="${ES_PATH_CONF}/logs"
ENV PATH="/usr/share/java/elasticsearch/bin:${PATH}"

RUN mkdir -p ${ES_TMPDIR} ${ES_PATH_LOG} /var/lib/elasticsearch/_default/plugins
RUN chown -R elastico:elastico ${ES_PATH} ${ES_PATH_CONF} /var/lib/elasticsearch

### YOUR TIME ZONE
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY --chown=elastico:elastico ./docker/config/. ${ES_PATH_CONF}/ 

EXPOSE $ES_PORT_REST/tcp 
EXPOSE $ES_PORT_REST/udp
EXPOSE $ES_PORT_NODES/tcp
EXPOSE $ES_PORT_NODES/udp

WORKDIR ${ES_PATH_CONF}

USER elastico
ENTRYPOINT ["elasticsearch"]
