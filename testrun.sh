#!/bin/bash


mkdir -p testrun/db
mkdir -p testrun/pkgout

./build.sh

docker run --name archpkg-test --env PACKAGE_NAME=python-octodns \
	-v $(pwd)/testrun/db:/db -v $(pwd)/testrun/pkgout:/pkgout \
	archpkg

docker rm archpkg-test
