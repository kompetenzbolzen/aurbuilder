#!/bin/bash

docker pull archlinux:base-devel
#docker build --no-cache -t archpkg .
docker build -t archpkg .
