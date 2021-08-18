#!/bin/bash
if [[ -z $1 ]]; then
    echo 'Version pattern should be specified'
    exit -1
fi
VERSION_PATTERN=$1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LIST_VERSIONS_PATH="$DIR/list_versions.sh"

VERSIONS=`. $LIST_VERSIONS_PATH | grep -oP '^\S+' | grep -v 'CONFIG_ID' | grep "$VERSION_PATTERN"`
for VERSION in  $VERSIONS; do
    echo "delete $VERSION"
    gcloud api-gateway api-configs delete $VERSION --api public-api --quiet
done