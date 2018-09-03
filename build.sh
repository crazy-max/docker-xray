#!/bin/bash

DOCKER_USERNAME=${DOCKER_USERNAME:-"crazymax"}
DOCKER_PASSWORD=${DOCKER_PASSWORD:-""}
DOCKER_REPONAME=${DOCKER_REPONAME:-"xray"}
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

if [ -z ${TOKEN} -o ${TOKEN} == "null" ]; then
  echo "Cannot retrieve token. Check your docker's credentials."
  exit 1
fi

function docker_pull() {
  echo "### Pulling Artifactory $2 $3 from $1..."
  TAG_EXISTS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${DOCKER_USERNAME}/${DOCKER_REPONAME}/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2-$3\"] | any")
  echo "Check tag exists : $TAG_EXISTS"
  if [ "${TAG_EXISTS}" = "true" ]; then
    echo "Tag $2-$3 already exists... Skipping..."
  else
    docker pull $1:$3
    docker tag $1:$3 ${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
    docker tag $1:$3 quay.io/${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
  fi
}

# Xray DB mongo
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/xray-mongo" "mongo" "$version"
done < "./images/xray-mongo.txt"

# Xray DB postgres
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/xray-postgres" "postgres" "$version"
done < "./images/xray-postgres.txt"

# Xray DB rabbitmq
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/xray-rabbitmq" "rabbitmq" "$version"
done < "./images/xray-rabbitmq.txt"

# Xray persist
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/xray-persist" "persist" "$version"
done < "./images/xray-persist.txt"

# Xray analysis
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/xray-analysis" "analysis" "$version"
done < "./images/xray-analysis.txt"

# Xray indexer
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/xray-indexer" "indexer" "$version"
done < "./images/xray-indexer.txt"

# Xray server
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/xray-server" "server" "$version"
done < "./images/xray-server.txt"
