#!/usr/bin/env bash

set -e

cf create-service p.mysql db-small zipkin_mysql
cf create-service p-rabbitmq standard zipkin_span_stream
