#!/usr/bin/env bash

if [ -z "$TARGET_BACKEND" ] ; then
  echo "ERROR: \$TARGET_BACKEND environment variable is required" ;
  exit 1;
fi

if [ -z "$APIGEE_ORG" ] ; then
  echo "ERROR: \$APIGEE_ORG environment variable is required" ;
  exit 1;
fi

if [ -z "$APIGEE_ENV" ] ; then
  echo "ERROR: \$APIGEE_ENV environment variable is required" ;
  exit 1;
fi

if [ -z "$APIGEE_USERNAME" ] ; then \
  echo "ERROR: \$APIGEE_USERNAME environment variable is required" ;
  exit 1;
fi

if [ -z "$APIGEE_PASSWORD" ] ; then
  echo "ERROR: \$APIGEE_PASSWORD environment variable is required" ;
  exit 1;
fi

APIGEE_HOSTURL=${APIGEE_HOSTURL:-}

docker build \
      --build-arg "CACHE_BUST=$(date +%s)" \
      --build-arg "TARGET_BACKEND=${TARGET_BACKEND}" \
      --build-arg "APIGEE_ORG=${APIGEE_ORG}" \
      --build-arg "APIGEE_ENV=${APIGEE_ENV}" \
      --build-arg "APIGEE_HOSTURL=${APIGEE_HOSTURL}" \
      --build-arg "APIGEE_USERNAME=${APIGEE_USERNAME}" \
      --build-arg "APIGEE_PASSWORD=${APIGEE_PASSWORD}" \
      -t apigee-graphql-demo-build \
      .

docker rmi -f apigee-graphql-demo-build
