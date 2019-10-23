FROM maven:3

RUN mkdir /repos



ARG APIGEE_ORG
ARG APIGEE_ENV
ARG APIGEE_HOSTURL
ARG APIGEE_USERNAME
ARG APIGEE_PASSWORD
ARG TARGET_BACKEND



ENV APIGEE_ORG ${APIGEE_ORG}
ENV APIGEE_ENV ${APIGEE_ENV}
ENV APIGEE_HOSTURL ${APIGEE_HOSTURL}
ENV APIGEE_USERNAME ${APIGEE_USERNAME}
ENV APIGEE_PASSWORD ${APIGEE_PASSWORD}
ENV TARGET_BACKEND ${TARGET_BACKEND}

ARG CACHE_BUST
ENV CACHE_BUST ${CACHE_BUST}

## Deploy GaphQL demo OAuth proxy
COPY apigee-graphql-demo-oauth repos/oauth
RUN echo " ***** Deploying OAuth Proxy (${CACHE_BUST}) *****" && \
    cd repos/oauth && \
    mvn -ntp install \
        -Ptest \
        -Dapigee.username=${APIGEE_USERNAME} \
        -Dapigee.password=${APIGEE_PASSWORD} \
        -Dapigee.org=${APIGEE_ORG} \
        -Dapigee.env=${APIGEE_ENV} \
        -Dapigee.hosturl=${APIGEE_HOSTURL}


# Deplloy GraphQL demo main proxy
COPY apigee-graphql-demo-proxy repos/proxy
RUN echo " ***** Deploying GraphQL Proxy (${CACHE_BUST}) *****" && \
    cd repos/proxy && \
    mvn -ntp install \
        -Ptest \
        -Dtarget_backend=${TARGET_BACKEND} \
        -Dapigee.username=${APIGEE_USERNAME} \
        -Dapigee.password=${APIGEE_PASSWORD} \
        -Dapigee.org=${APIGEE_ORG} \
        -Dapigee.env=${APIGEE_ENV} \
        -Dapigee.hosturl=${APIGEE_HOSTURL}

## Deplloy main GraphQL demo config assets
COPY apigee-graphql-demo-config repos/config
RUN echo " ***** Deploying Config Proxy (${CACHE_BUST}) *****" && \
    cd repos/config && \
    mvn -ntp install \
        -Ptest \
        -Dapigee.username=${APIGEE_USERNAME} \
        -Dapigee.password=${APIGEE_PASSWORD} \
        -Dapigee.org=${APIGEE_ORG} \
        -Dapigee.env=${APIGEE_ENV} \
        -Dapigee.hosturl=${APIGEE_HOSTURL}