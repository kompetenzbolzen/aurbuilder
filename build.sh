#!/bin/bash

DOCKER=podman

#podman image prune

$DOCKER pull archlinux:base-devel
$DOCKER build --no-cache -t aurbuilder container/
#$DOCKER build -t aurbuilder docker/
