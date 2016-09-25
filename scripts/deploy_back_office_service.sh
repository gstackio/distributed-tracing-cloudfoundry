#!/usr/bin/env bash

set -e

pushd acme-financial-back-office-microservice
cf push
popd
