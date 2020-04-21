# Multi-stage build example for Velocity 2018

This repository contains a working example for the talk at Velocity 2018 in London on _Advanced Docker image build patterns_. The focus is on the Dockerfile, with other tooling or code included to make that example actually work. The application is written in Python, but hopefully the ideas should be pretty generally applicable. The Makefile is included as much as documentation as for actual usage. I've included an annotated version of the `Dockerfile` below.

```dockerfile
# We name the `base` stage so we can refence it in multiple later
# stages but only need to update it in one place if we change it
FROM python:3-alpine AS base

WORKDIR /app
RUN pip install pipenv==2018.10.13

COPY Pipfile /app/
COPY Pipfile.lock /app/

RUN pipenv install --system --deploy


# The `app` stage is used as the base for images that don't
# need the development dependencies
FROM base AS app
COPY src /app


# The `test-base` stage is used as the base for images that require
# the development dependencies. The duplication of the COPY instruction
# avoids breaking the cache for that later when the Pipfile changes 
FROM base AS test-base
RUN pipenv install --system --deploy --dev
COPY src /app


# The `Test` stage runs the application unit tests, the build will fail
# if the tests fail. Note this stage name is capitalised, this is purely
# a convetion for stages which result in useful images. Think of it like
# hint that this is a public interface
FROM test-base AS Test
RUN pytest --black


# The `Check` stage runs a check of the package dependencies against a list
# of known security vulnerabilities. The build will fail if vulnerabilities
# are found
FROM test-base AS Check
RUN safety check


# The `Security` stage checks the application for security vulnerabilities using the 
# Aqua MicroScanner. This requires providing a build-arg with your MicroScanner token
FROM app AS Security
ARG MICROSCANNER
RUN wget -O /microscanner https://get.aquasec.com/microscanner && chmod +x /microscanner
RUN /microscanner $MICROSCANNER --full-output


# The `Docs` stage builds documentation from the application source code
# and serves that on a simple web server
FROM test-base AS Docs
RUN pycco -i *.py
WORKDIR /app/docs
EXPOSE 8000
CMD ["python", "-m", "http.server"]


# `Shell` will build an image that, when run, drops you into a 
# python shell with the application context loaded
FROM app AS Shell
CMD ["flask", "shell"]


# `release` acts as the basis for images which will actually run the application 
FROM app AS release
EXPOSE 5000


# `Dev` runs the application using the development web server, and enables
# developer tools like the debugger and interactive expcetions
FROM release AS Dev
ENV FLASK_ENV=development
CMD ["python", "app.py"]


# The `Prod` stage is the default stage if the Dockerfile is run without 
# a target stage set. The resulting image will run the application using a
# production webserver and configuration
FROM release As Prod
CMD ["gunicorn", "-b", ":5000", "app:app"]
```

## Google Cloud Build

The above Dockerfile is also used for running the tests in Google Cloud Build. See the accompanying `cloudbuild.yaml` file for details. The plan is to mechanically generate this file from the `Dockerfile`. 


## GitHub Actions

The Dockerfile is also used for running on GitHub with GitHub Actions. If you're thinking this duplicates the Google Cloud Build example you'd be right. This repository is intended as an example and playground. As with the `cloudbuild.yaml` file above it should be possible to mechanically generate this too.

```hcl
workflow "Quality" {
   on = "push"
   resolves = ["check", "test", "lint", "security", "validate"]
 }

 action "check" {
   uses = "actions/docker/cli@master"
   args = "build --target check ."
 }

 action "test" {
   uses = "actions/docker/cli@master"
   args = "build --target test ."
 }

 action "security" {
   uses = "actions/docker/cli@master"
   secrets = ["MICROSCANNER"]
   args = "build --target security --build-arg MICROSCANNER=${MICROSCANNER} ."
 }

 action "lint" {
   uses = "actions/docker/cli@master"
   args = "run -i hadolint/hadolint hadolint --ignore SC2035 - < Dockerfile"
 }

 action "build" {
   uses = "actions/docker/cli@master"
   args = "build -t sample ."
 }

 action "validate" {
   uses = "docker://gcr.io/gcp-runtimes/container-structure-test"
   needs = "build"
   args = "test --image sample --config structure-tests.yaml"
 }
```


## Knative Build

[Knative Build](https://github.com/knative/build) is a CRD for Kubernetes which supports building in a cluster. I've also included a sample `buildtemplate.yaml` which demonstrates using Knative Build to run the above checks as well. This template uses a local Docker socket for demonstration purposes but could be converted to a different builder if needed.
