#!/usr/bin/env bash

if [ -z "$TARGET_BACKEND" ] ; then
  echo "ERROR: \$TARGET_BACKEND environment variable is required" ;
  exit 1;
fi

if [ -z "$APIGEE_ORG" ] ; then
  echo "ERROR: \$APIGEE_ORG environment variable is required" ;
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


docker build \
      --build-arg CACHEBUST=$(date +%s) \
      --build-arg "TARGET_BACKEND=${TARGET_BACKEND}" \
      --build-arg "APIGEE_ORG=${APIGEE_ORG}" \
      --build-arg "APIGEE_USERNAME=${APIGEE_USERNAME}" \
      --build-arg "APIGEE_PASSWORD=${APIGEE_PASSWORD}" \
      -t apigee-graphql-demo-build \
      .

docker rmi -f apigee-graphql-demo-build
