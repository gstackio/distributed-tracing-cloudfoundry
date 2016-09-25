[![Build Status](https://travis-ci.org/spring-cloud-samples/sleuth-documentation-apps.svg)](https://travis-ci.org/spring-cloud-samples/sleuth-documentation-apps)

# Sleuth documentation apps

[Apps used for the Sleuth documentation graphs](http://cloud.spring.io/spring-cloud-sleuth/spring-cloud-sleuth.html) . They're not using
service discovery so don't treat them as reference production applications ;)

The apps are sending spans to Zipkin via RabbitMQ and `spring-cloud-sleuth-stream`.

# Deploying to Cloud Foundry

1. Confirm the org and space you are logged into. The apps will be deployed here.

1. `./scripts/create_services.sh`

1. `./scripts/build.sh && ./scripts/deploy_leaf_services.sh`

1. Look up the route for each leaf service via `cf apps` and put them into `scripts/deploy_back_office_service.sh`

1. `./scripts/deploy_back_office_service.sh`

1. Look up the route for the back office service via `cf apps` and put it into `scripts/deploy_ui.sh`

1. `./scripts/deploy_ui.sh`

1. Confirm that everything is wired together properly with `curl <uiUrlFromCfApps>/start`. The output should be:

```
Hello from Acme Financial's Backend service. Calling Acme Financial's Account Service [Hello from Acme Financial's Account Microservice] and then Customer Service [Hello from Acme's Customer Microservice]
```

1. `./scripts/deploy_zipkin.sh`

1. Confirm that the Zipkin UI is working via a browser using the URL from `cf apps`



# Running the apps locally with RabbitMQ

You need to have Docker installed.

Provide the env variable `DEFAULT_HEALTH_HOST` pointing to your Docker Machine. By default it will be `localhost`.
That way we'll start a RabbitMQ instance for you.

Run:

```
./scripts/start_with_zipkin_server.sh
```

# Interactions

Run:
```
./scripts/curl_start.sh
```

You can then navigate to http://localhost:9411/ to see the Zipkin dashboard.

# Troubleshooting

You can tail the .log files in build/ to see what it happening.
