#!/bin/bash

DOCKER=podman

podman image prune

$DOCKER pull archlinux:base-devel
$DOCKER build --no-cache -t aurbuilder docker/
#$DOCKER build -t aurbuilder docker/
