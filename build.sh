#!/bin/bash

DOCKER=podman

$DOCKER pull archlinux:base-devel
$DOCKER build --no-cache -t archpkg docker/
#$DOCKER build -t archpkg docker/
