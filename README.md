<p align="center">
  <a href="https://microbadger.com/images/crazymax/xray"><img src="https://images.microbadger.com/badges/version/crazymax/xray.svg?style=flat-square" alt="Version"></a>
  <a href="https://travis-ci.org/crazy-max/docker-xray"><img src="https://img.shields.io/travis/crazy-max/docker-xray/master.svg?style=flat-square" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/xray/"><img src="https://img.shields.io/docker/stars/crazymax/xray.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/xray/"><img src="https://img.shields.io/docker/pulls/crazymax/xray.svg?style=flat-square" alt="Docker Pulls"></a>
  <a href="https://quay.io/repository/crazymax/xray"><img src="https://quay.io/repository/crazymax/xray/status?style=flat-square" alt="Docker Repository on Quay"></a>
</p>

## About

This is a simple mirror of [Xray](https://jfrog.com/xray/) Docker images taken from [JFrog Docker Registry](https://bintray.com/jfrog/reg2) and push to [Docker Hub](https://hub.docker.com/r/crazymax/xray/) and [Quay](https://quay.io/repository/crazymax/xray).<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other 🐳 Docker images!

The following images are mirrored :

* [xray-server](https://bintray.com/jfrog/reg2/jfrog%3Axray-server) : Generating violations, hosting API / UI endpoints, running scheduled jobs
* [xray-indexer](https://bintray.com/jfrog/reg2/jfrog%3Axray-indexer) : Responsible for the indexing process
* [xray-analysis](https://bintray.com/jfrog/reg2/jfrog%3Axray-analysis) : Responsible for enriching component metadata
* [xray-persist](https://bintray.com/jfrog/reg2/jfrog%3Axray-persist) : Matching the given components graph, completing component naming, storing the data in the relevant databases
* [xray-rabbitmq](https://bintray.com/jfrog/reg2/jfrog%3Axray-rabbitmq) : Microservice Communication and Messaging
* [xray-postgres](https://bintray.com/jfrog/reg2/jfrog%3Axray-postgres) : Components Graph Database
* [xray-mongo](https://bintray.com/jfrog/reg2/jfrog%3Axray-mongo) : Components Metadata and Configuration

And are placed in the same repository on Docker Hub with translated tags. Here is a translation example :

| JFrog registry                                         | Docker Hub                              |
| ------------------------------------------------------ | --------------------------------------- |
| docker.bintray.io/jfrog/xray-server:2.3.2              | crazymax/xray:server-2.3.2              |
| docker.bintray.io/jfrog/xray-indexer:2.3.2             | crazymax/xray:indexer-2.3.2             |
| docker.bintray.io/jfrog/xray-analysis:2.3.2            | crazymax/xray:analysis-2.3.2            |
| docker.bintray.io/jfrog/xray-persist:2.3.2             | crazymax/xray:persist-2.3.2             |
| docker.bintray.io/jfrog/xray-rabbitmq:3.6.1-management | crazymax/xray:rabbitmq-3.6.1-management |
| docker.bintray.io/jfrog/xray-postgres:9.5.2            | crazymax/xray:postgres-9.5.2            |
| docker.bintray.io/jfrog/xray-mongo:3.2.6               | crazymax/xray:mongo-3.2.6               |

More info :

* https://www.jfrog.com/confluence/display/XRAY/Installing+Xray
* https://www.jfrog.com/confluence/display/XRAY/Xray+High+Availability
* https://github.com/jfrog/artifactory-docker-examples
