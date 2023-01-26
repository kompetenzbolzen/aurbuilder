#!/bin/bash
# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Custom_local_repository

OUTDIR="testrun/db/"
PKGDIR="testrun/db/"

mkdir -p "$OUTDIR"

repo-add -n "$OUTDIR/repo.db.tar.gz" "$PKGDIR/pkgout/*.pkg.*"

rm "$OUTDIR/*.old"
