## Apigee GraphQL Demo


### Description

This repo contains instructions (and automation) for deploying a set of proxies and resources in 
Apigee Edge that demonstrate the tooling provided in the [graphql-authz](https://github.com/apigee/graphql-authz) repo. 

   
### Components

  The demo contains several components. Each component is located in its own git repo, which are added as
  submodules in this repo:
  
  1. [apigee-graphql-demo-server](https://github.com/micovery/apigee-graphql-demo-server)
  2. [apigee-graphql-demo-proxy](https://github.com/micovery/apigee-graphql-demo-proxy) 
  3. [apigee-graphql-demo-oauth](https://github.com/micovery/apigee-graphql-demo-oauth)
  4. [apigee-graphql-demo-config](https://github.com/micovery/apigee-graphql-demo-config)
  4. [apigee-graphql-demo-portal](https://github.com/micovery/apigee-graphql-demo-portal)

  

### Build Prerequisites

  * bash (Linux shell)
  * [Docker (18 or newer)](https://www.docker.com/)
  
### Deploying the target backend GraphQL server

For this demo you will need to have a target backend GraphQL server. The server needs to be reachable from
the internet so that Apigee edge is able to forward requests to it. 

Take a look at the repo [apigee-graphql-demo-server](https://github.com/micovery/apigee-graphql-demo-server) for
instructions on how to deploy the demo GraphQL Server. This GraphQL server comes already loaded with a sample
schema (ski resorts), as well as plugins for collecting and uploading analytics data to Apigee Edge and [Stackdriver](https://cloud.google.com/stackdriver/).


### Deploying the Apigee Edge Components

For this demo to work, there are several components that need to be deployed to your Apigee Edge organization. 
These are `graphql-proxy`, `graphql-oauth` and `graphql-config`.

Rather than going to the each individual repo and installing the components separately, you can use the [build.sh](/build.sh)
script and deploy all these components in one shot. To do this, follow the instructions below:

1. Clone this repo (including submodules)

    ```bash
    $ git clone --recurse-submodules git@github.com:micovery/apigee-graphql-demo.git
    ```

2. Run the these commands:
    ```bash
    $ export TARGET_BACKEND=https://your.backend.serveo.com/graphql
    $ export APIGEE_USERNAME=username@examle.com
    $ export APIGEE_PASSWORD=SuperSecret#123
    $ export APIGEE_ORG=your-apigee-org
    ```

   ```bash
   $ ./build.sh
   ```
 
After the build is complete, you should have two new proxies (`graphq-proxy`, `graphql-server`) in your Apigee Edge org.

You should also see a new Key-Value-Map (KVM) called `graphql`. This KVM contains metadata used by the `graphql-proxy`. 
### Deploying the Developer Portal with GraphQL

Once you have the Apigee Edge components, the final step is to stand up a developer portal where you
can create apps, and use the GraphQL playground to explore the schema exposed by the `graphql-proxy` API Proxy.

Take at the [apigee-graphql-demo-portal](https://github.com/micovery/apigee-graphql-demo-portal) repo for instructions.
   
   
## Not Google Product Clause

This is not an officially supported Google product.
