#!/bin/bash
set -e

DOCKER_USERNAME=${DOCKER_USERNAME:-crazymax}
DOCKER_REPONAME=${DOCKER_REPONAME:-xray}
QUAY_USERNAME=${QUAY_USERNAME:-crazymax}
QUAY_REPONAME=${QUAY_REPONAME:-xray}

if [[ -z $(docker image ls ${DOCKER_USERNAME}/${DOCKER_REPONAME} --format "{{.ID}}") ]]; then
  echo "No tag to push"
  exit 0
fi

if [ ! -z ${DOCKER_PASSWORD} ]; then
  echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
  docker push ${DOCKER_USERNAME}/${DOCKER_REPONAME}
fi

if [ ! -z ${QUAY_PASSWORD} ]; then
  echo "$QUAY_PASSWORD" | docker login quay.io --username "$QUAY_USERNAME" --password-stdin
  docker push quay.io/${DOCKER_USERNAME}/${DOCKER_REPONAME}
fi
