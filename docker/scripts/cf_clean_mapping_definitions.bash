#!/usr/bin/env bash
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com


declare -g DEFAULT_ES_PORT_REST="";
declare -g es_host="";
declare -g es_port="";


DEFAULT_ES_PORT_REST=9200;

es_host="localhost";
es_port="$1"; shift;

if [ -z "${es_port}" ]; then
      es_port="$DEFAULT_ES_PORT_REST";
fi

curl -XDELETE http://${es_host}:${es_port}/cf_tags
echo ""
curl -XDELETE http://${es_host}:${es_port}/channelfinder
echo ""
curl -XDELETE http://${es_host}:${es_port}/cf_properties
echo ""
