#!/bin/bash

mkdir -p testrun/pkgout

./build.sh

docker run --name archpkg-test --env PACKAGE_NAME=minipro \
	--env FORCE_REBUILD=yes --env CHOWN="$UID:$(id -g "$USER")" \
	-v "$(pwd)/testrun/pkgout:/pkgout" \
	archpkg

docker rm archpkg-test
