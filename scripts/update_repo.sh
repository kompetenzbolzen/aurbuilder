#!/bin/bash

test -f /etc/aurbuilder/config && source /etc/aurbuilder/config

OUTPUT=${OUTPUT:-/srv/pkg/}
REPONAME=${REPONAME:-repo}

repo-add -p -R "$OUTPUT/$REPONAME.db.tar.gz" "$OUTPUT/"*.pkg.* || exit 1
rm -f "$OUTDIR/"*.old
