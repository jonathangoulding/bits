#!/usr/bin/env bash
echo "Starting Mongo as a replica set"

CONTAINER_NAME="${1:-mongo}"
echo "Naming mongo container: $CONTAINER_NAME"

# Manage network connection from start script, if start script used connect to the user defined bridge network, else default network (means this script can be standalone)
[[ -n $NETWORK_NAME ]] && NETWORK="--network=$NETWORK_NAME --network-alias=mongo" || NETWORK=""

docker rm -f $CONTAINER_NAME 2> /dev/null

MONGO_IMAGE="mongo:4.4.4@sha256:10c5bfb6984134009c376e7a37c8523da195c9b8c5b9828bcc564efe55b32579"

docker run -d \
        -p 27017:27017 \
        $NETWORK \
        --name "$CONTAINER_NAME" \
        $MONGO_IMAGE --replSet=test

sleep 5
docker exec -t "$CONTAINER_NAME" mongo --quiet --eval "rs.initiate()" exit
