#!/bin/bash

OUTPUT=${OUTPUT:-/srv/pkg/}
repo-add -pR "$OUTPUT/repo.db.tar.gz" "$OUTPUT/"*.pkg.* || exit 1
rm -f "$OUTDIR/"*.old
