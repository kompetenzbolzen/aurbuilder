#!/bin/bash

docker pull archlinux:base-devel
#docker build --no-cache -t archpkg docker/
docker build -t archpkg docker/
