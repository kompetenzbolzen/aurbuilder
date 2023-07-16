#!/bin/bash

PODMAN=$(which podman)
DIR=${DIR:-/usr/share/aurbuilder}

$PODMAN pull archlinux:base-devel
$PODMAN build --no-cache -t aurbuilder "$DIR"
