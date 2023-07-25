#!/bin/bash

DOCKER=podman

mkdir -p testrun/pkgout

CHOWN_TO="$USER"
OUTPUT="$(pwd)/testrun/pkgout"

#./build.sh

$DOCKER run --userns=host --name archpkg-test --env PACKAGE_NAME=minipro \
	--env FORCE_REBUILD=yes --env CHOWN="$(id -u "$CHOWN_TO"):$(id -g "$CHOWN_TO")" \
	-v "$OUTPUT:/pkgout:z" \
	aurbuilder

$DOCKER rm archpkg-test
