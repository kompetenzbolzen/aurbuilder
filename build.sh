#!/bin/bash

docker pull archlinux:base-devel
docker build -t archpkg .
