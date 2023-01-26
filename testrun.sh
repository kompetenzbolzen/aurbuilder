#!/bin/bash

mkdir -p testrun/pkgout

CHOWN_TO="$USER"
OUTPUT="$(pwd)/testrun/pkgout"

./build.sh

docker run --name archpkg-test --env PACKAGE_NAME=minipro \
	--env FORCE_REBUILD=yes --env CHOWN="$(id -u "$CHOWN_TO"):$(id -g "$CHOWN_TO")" \
	-v "$OUTPUT:/pkgout" \
	archpkg

docker rm archpkg-test
