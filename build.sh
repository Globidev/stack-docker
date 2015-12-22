#!/usr/bin/env bash

set -eu

uid=$(id -u $USER)
gid=$(id -g $USER)
user=$(id -un $USER)
group=$(id -gn $USER)

# Build the actual image
image_name="haskell-stack"
docker build \
    --build-arg uid="$uid" \
    --build-arg gid="$gid" \
    --build-arg user="$user" \
    --build-arg group="$group" \
    --tag "$image_name" \
    .

# Create a named volume for stack's storage (global-stack-root)
volume_name="stack-root"
docker volume create \
    --name "$volume_name"

# Create a user owned directory in the volume
set +e
volume_builder_name="stack-root-builder-tmp"
docker run \
    --name "$volume_builder_name" \
    --volume "$volume_name":/stack \
    busybox \
    sh -c "mkdir -p \"/stack/$user\" && chown -R $uid:$gid \"/stack/$user\""

docker rm "$volume_builder_name"
