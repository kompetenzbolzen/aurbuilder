#!/bin/bash

OUTPUT=${OUTPUT:-/srv/pkg/}
repo-add -p -R "$OUTPUT/repo.db.tar.gz" "$OUTPUT/"*.pkg.* || exit 1
rm -f "$OUTDIR/"*.old
