# EPICS Middleware Index Mappings Elasticsearch (Alpine 3.12 / ES 6.4.3)

![Docker Image CI](https://github.com/jeonghanlee/es4epics/workflows/Docker%20Image%20CI/badge.svg)


## Notice

This image only have been tested with a local and personal environment, not with any production environment. Thus, please don't use this image for any deployment or production purpose.

## Build

* Build the docker image

```bash
make build
```

* Start the built docker image

```bash
$ make es.start
docker run -d --rm -p 9200:9200 --name=es4epics jeonghanlee/es4epics
```

If there is the same name container running, please stop it via `docker stop es4epics` or `make es.make stop`.

* Mapping the ChannelFinder index mapping

Before doing this, it would be wise to check the elasticsearch service is running first via `make es.status`.

```bash
make es.mappings
>>> index/mapping : cf_tags ....
{"acknowledged":true,"shards_acknowledged":true,"index":"cf_tags"}
>>> index/mapping : cf_properties ....
{"acknowledged":true,"shards_acknowledged":true,"index":"cf_properties"}
>>> index/mapping : channelfinder ....
{"acknowledged":true,"shards_acknowledged":true,"index":"channelfinder"}
```

```bash
make es.release.dryrun
```

```bash
make es.release
```

* Check the elasticseach server logs

```bash
make es.status
```

* Stop the running container

```bash
make es.stop
```

* Check the relased image

```bash
make docker.images
```

## `docker/config`

That folder contains the elasticsearch configuration files.
