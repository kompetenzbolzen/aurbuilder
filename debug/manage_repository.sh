#!/bin/bash
# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Custom_local_repository

OUTDIR="testrun/db/"
PKGDIR="testrun/pkgout/"

mkdir -p "$OUTDIR"

repo-add -p -R "$OUTDIR/repo.db.tar.gz" "$PKGDIR/"*.pkg.*

rm "$OUTDIR/"*.old
