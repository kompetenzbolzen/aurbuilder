#!/bin/bash

echo "BUILDING: $PACKAGE_NAME"
echo "PACKAGER: $PACKAGER"

INTERMED_DEST="/pkgdest"

cd /workdir || exit 1

while read -r NAME BASE VER _; do
	echo "$NAME $VER for $ARCH"
	OUTNAME="$NAME-$VER-$ARCH.pkg"

	# Only build when needed
	if [ ! "$FORCE_REBUILD" = "yes" ] && compgen -G "/pkgout/${OUTNAME}*"; then
		echo "$NAME $VER ($ARCH) is already built. Skipping."
		# TODO: install the package! it is a dependency!
		continue
	fi

	sudo --user=aurbuilder \
		git clone "https://aur.archlinux.org/$BASE.git" "$BASE"
	cd "$BASE" || exit 1

	sudo -u aurbuilder CARCH="$ARCH" PACKAGER="$PACKAGER" PKGDEST="$INTERMED_DEST" \
		makepkg --force --syncdeps --noconfirm --install

	cp --no-preserve=ownership "$INTERMED_DEST/"*.pkg.tar.zst /pkgout
	#test -n "$CHOWN" && sudo chown "$CHOWN" "/pkgout/${OUTNAME}"*
done <<< "$(getpackage.py "$PACKAGE_NAME")"
