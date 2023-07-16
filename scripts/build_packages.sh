#!/bin/bash

PODMAN=$(which podman)

CONFFILE=${CONFFILE:-/etc/aurbuilder/packages}
OUTPUT=${OUTPUT:-/srv/pkg/}
FORCE_REBUILD=${FORCE_REBUILD:-no}
CHOWN_TO=${CHOWN_TO:-$USER}

if ! ($PODMAN image list | grep aurbuilder > /dev/null); then
	echo Container image \"aurbuilder\" was not found. Was it built?
	exit 1
fi

ERROR=0
ERR_PKGS=()

while read -r LINE; do
	[[ $LINE == \#* ]] && continue
	echo ""
	echo "BUILDING $LINE"
	echo "======================="
	echo ""
	echo ""

	CONT_NAME="aurbuilder-$RANDOM"
	$PODMAN run --userns=host --name "$CONT_NAME" \
		--env PACKAGE_NAME="$LINE" \
		--env FORCE_REBUILD="$FORCE_REBUILD" \
		--env CHOWN="$(id -u "$CHOWN_TO"):$(id -g "$CHOWN_TO")" \
		-v "$OUTPUT:/pkgout:z" \
		aurbuilder \
	RET=$?
	$PODMAN rm "$CONT_NAME"

	if [ "$RET" -ne 0 ]; then
		ERROR=1
		ERR_PKGS+=("$LINE")
	fi
done < "$CONFFILE"

if [ "$ERROR" -ne 0 ]; then
	echo There were Errors while building following packages: "${ERR_PKGS[@]}"
	exit 1
fi

