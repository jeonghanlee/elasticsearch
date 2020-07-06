#
#  author  : Jeong Han Lee
#  email   : jeonghan.lee@gmail.com

FROM elasticsearch:6.8.10

LABEL maintainer="Jeong Han Lee <jeonghan.lee@gmail.com>"

ARG BUILD_DATE
ARG BUILD_VERSION
ARG TZ=America/Los_Angeles


LABEL maintainer="Jeong Han Lee <jeonghan.lee@gmail.com>"
# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="jeonghanlee/es-epics-middleware"
LABEL org.label-schema.description="EPICS Elasticsearch EPICS middleware Docker Image"
LABEL org.label-schema.url="https://github.com/jeonghanlee/es-epics-middleware"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run --network=host --detach --rm --name=elasticsearch jeonghanlee/elasticsearch:tagname"

ENV TZ ${TZ}
ENV ES_PATH_CONF "/etc/elasticsearch"
ENV PATH="/usr/share/java/elasticsearch/bin:${PATH}"

COPY ./mapping_definitions.bash /mapping_definitions.bash

### YOUR TIME ZONE
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD "elasticsearch"

