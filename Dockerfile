FROM maven:3

RUN mkdir /repos

ARG CACHE_BUST=0

ARG APIGEE_ORG
ARG APIGEE_USERNAME
ARG APIGEE_PASSWORD
ARG TARGET_BACKEND

ENV APIGEE_ORG ${APIGEE_ORG}
ENV APIGEE_USERNAME ${APIGEE_USERNAME}
ENV APIGEE_PASSWORD ${APIGEE_PASSWORD}
ENV TARGET_BACKEND ${TARGET_BACKEND}

# Deploy GaphQL demo OAuth proxy
COPY apigee-graphql-demo-oauth repos/oauth
RUN cd repos/oauth && \
    mvn -ntp install \
        -Ptest \
        -Dorg=${APIGEE_ORG} \
        -Dusername=${APIGEE_USERNAME} \
        -Dpassword=${APIGEE_PASSWORD}

# Deplloy GraphQL demo main proxy
COPY apigee-graphql-demo-proxy repos/proxy
RUN cd repos/proxy && \
    mvn -ntp install \
        -Ptest \
        -Dtarget_backend=${TARGET_BACKEND} \
        -Dorg=${APIGEE_ORG} \
        -Dusername=${APIGEE_USERNAME} \
        -Dpassword=${APIGEE_PASSWORD}

# Deplloy main GraphQL demo config assets
COPY apigee-graphql-demo-config repos/config
RUN cd repos/config && \
    mvn -ntp install \
        -Ptest \
        -Dorg=${APIGEE_ORG} \
        -Dusername=${APIGEE_USERNAME} \
        -Dpassword=${APIGEE_PASSWORD}