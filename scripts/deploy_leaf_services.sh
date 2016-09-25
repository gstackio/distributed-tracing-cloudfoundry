#!/bin/bash

set -e

pushd acme-financial-account-microservice
cf push &
popd
pushd acme-financial-customer-microservice
cf push &
popd

wait
