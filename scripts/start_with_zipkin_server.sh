#!/bin/bash

set -e

RABBIT_PORT=${RABBIT_PORT:-9672}
DEFAULT_HEALTH_HOST=${DEFAULT_HEALTH_HOST:-localhost}
DEFAULT_ARGS="-DSPRING_RABBITMQ_HOST=${DEFAULT_HEALTH_HOST} -DSPRING_RABBITMQ_PORT=${RABBIT_PORT}"

[[ -z "${MEM_ARGS}" ]] && MEM_ARGS="-Xmx128m -Xss1024k"

mkdir -p build

# build apps
./gradlew clean build --parallel

# run zipkin stuff
docker-compose kill
docker-compose build
docker-compose up -d

echo -e "\nStarting Zipkin Server..."
nohup $JAVA_HOME/bin/java $DEFAULT_ARGS $MEM_ARGS -jar zipkin-server/build/libs/*.jar > build/zipkin-server.log &

echo -e "\nStarting the apps..."
nohup $JAVA_HOME/bin/java $DEFAULT_ARGS $MEM_ARGS -jar acme-financial-account-microservice/build/libs/*.jar > build/acme-financial-account-microservice.log &
nohup $JAVA_HOME/bin/java $DEFAULT_ARGS $MEM_ARGS -jar acme-financial-back-office-microservice/build/libs/*.jar > build/acme-financial-back-office-microservice.log &
nohup $JAVA_HOME/bin/java $DEFAULT_ARGS $MEM_ARGS -jar acme-financial-customer-microservice/build/libs/*.jar > build/acme-financial-customer-microservice.log &
nohup $JAVA_HOME/bin/java $DEFAULT_ARGS $MEM_ARGS -jar acme-financial-ui/build/libs/*.jar > build/acme-financial-ui.log &
