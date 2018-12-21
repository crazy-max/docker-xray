#!/bin/bash
set -e

DOCKER_USERNAME=${DOCKER_USERNAME:-crazymax}
DOCKER_REPONAME=${DOCKER_REPONAME:-xray}
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

if [ -z ${TOKEN} -o ${TOKEN} == "null" ]; then
  echo "Cannot retrieve token. Check your docker's credentials."
  exit 1
fi

TAG_LIST=""
function get_docker_tags() {
  for TAG in $(curl -s -H "Authorization: JWT ${TOKEN}" $1 | jq -rc '.results[]'); do
    TAG_LIST="$(echo "$TAG" | jq -r .name),$TAG_LIST"
  done
  NEXT_PAGE=$(curl -s -H "Authorization: JWT ${TOKEN}" $1 | jq -r '.next')
  if [[ ${NEXT_PAGE} != "null" ]]; then
    get_docker_tags ${NEXT_PAGE}
  fi
}

function docker_pull() {
  echo "### Pulling Xray $2 $3 from $1..."
  echo "Check if tag exists..."
  for TAG in $(echo ${TAG_LIST} | sed "s/,/ /g"); do
    if [[ "$TAG" = "$2-$3" ]]; then
      echo "Tag $2-$3 already exists... Skipping..."
      return
    fi
  done
  docker pull $1:$3
  docker tag $1:$3 ${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
  docker tag $1:$3 quay.io/${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
}

# Get all tags
echo "Get all tags..."
get_docker_tags https://hub.docker.com/v2/repositories/${DOCKER_USERNAME}/${DOCKER_REPONAME}/tags/?page_size=10000

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
