#!/bin/bash

PODMAN=$(which podman)
DIR=${DIR:-/usr/share/aurbuilder/container}

$PODMAN pull archlinux:base-devel
$PODMAN build --no-cache -t aurbuilder "$DIR"
