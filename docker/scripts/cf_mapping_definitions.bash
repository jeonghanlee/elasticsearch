#!/usr/bin/env bash

###
# #%L
# ChannelFinder Directory Service
# %%
# Copyright (C) 2010 - 2016 Helmholtz-Zentrum Berlin für Materialien und Energie GmbH
# %%
# Copyright (C) 2010 - 2012 Brookhaven National Laboratory
# All rights reserved. Use is subject to license terms.
# %%
# Copyright (c) 2020        Jeong Han Lee
# #L%
###
# The mapping definition for the Indexes associated with the channelfinder v4

#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Thursday, February 20 14:39:35 PST 2020
#   version : 0.0.1


declare -g DEFAULT_ES_PORT_REST="";
declare -g es_host="";
declare -g es_port="";



function print_help
{
    local a="$1"; shift;
    local b="$1"; shift;
    printf "\\n"
    printf ">>> %s : %s ....\\n" "$a" "$b";
}


DEFAULT_ES_PORT_REST=9200;

es_host="localhost";
es_port="$1"; shift;

if [ -z "${es_port}" ]; then
      es_port="$DEFAULT_ES_PORT_REST";
fi


#Create the Index
print_help "index/mapping" "cf_tags"

curl -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/cf_tags -d'
{
"mappings":{
  "cf_tag" : {
    "properties" : {
      "name" : {
        "type" : "keyword"
      },
      "owner" : {
        "type" : "keyword"
      }
    }
    }
  }
}'

print_help "index/mapping" "cf_properties"
curl -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/cf_properties -d'
{
"mappings":{
  "cf_property" : {
    "properties" : {
      "name" : {
        "type" : "keyword"
      },
      "owner" : {
        "type" : "keyword"
      }
    }
  }
  }
}'

print_help "index/mapping" "channelfinder"
curl -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/channelfinder -d'
{
"mappings":{
  "cf_channel" : {
    "properties" : {
      "name" : {
        "type" : "keyword"
      },
      "owner" : {
        "type" : "keyword"
      },
      "script" : {
        "type" : "keyword"
      },
      "properties" : {
        "type" : "nested",
        "properties" : {
          "name" : {
            "type" : "keyword"
          },
          "owner" : {
            "type" : "keyword"
          },
          "value" : {
            "type" : "keyword"
          }
        }
      },
      "tags" : {
        "type" : "nested",
        "properties" : {
          "name" : {
            "type" : "keyword"
          },
          "owner" : {
            "type" : "keyword"
          }
        }
      }
    }
  }
  }
}'

printf "\\n";
