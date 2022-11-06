#!/bin/bash

echo "BUILDING: $PACKAGE_NAME"
echo "Build Deps: $BUILD_ALL_AUR_DEPENDS"

cd /workdir || exit 1

while read NAME BASE VER _; do
	echo $NAME $BASE $VER

	sudo -u aurbuilder git clone "https://aur.archlinux.org/$BASE.git" "$BASE"
	cd "$BASE" || exit 1

	# TODO: PKGDEST instead of copy
	sudo -u aurbuilder makepkg --syncdeps --noconfirm --install

	cp ./*.pkg.tar.zst /pkgout
done <<< "$(getpackage.py "$PACKAGE_NAME")"
