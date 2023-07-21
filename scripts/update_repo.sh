#!/bin/bash

OUTPUT=${OUTPUT:-/srv/pkg/}
repo-add -pR "$OUTPUT/repo.db.tar.gz" "$OUTPUT/*.pkg.*"
rm "$OUTDIR/*.old"
