#!/bin/bash

set -e

pushd acme-financial-ui
cf push
popd
