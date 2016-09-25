#!/usr/bin/env bash

set -e

cf create-service p-mysql 100mb zipkin_mysql
cf create-service cloudamqp lemur zipkin_span_stream
