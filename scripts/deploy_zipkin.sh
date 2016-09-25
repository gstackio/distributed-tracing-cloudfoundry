#!/usr/bin/env bash

set -e

pushd zipkin-server
cf push
popd
