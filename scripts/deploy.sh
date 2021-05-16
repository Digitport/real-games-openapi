#!/bin/bash
if [[ -n $1 ]]; then
    echo "Suffix: \"$1\""
    SUFFIX="-$1"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
YAML_PATH="$DIR/../public-api.yaml"

VERSION=`grep "version:" $YAML_PATH | grep -oP "[0-9.]+" | sed "s|\.|-|g"`
echo "Version: $VERSION"

API_CONFIG="public-api-config-v$VERSION$SUFFIX"
gcloud api-gateway api-configs create "$API_CONFIG" \
    --api=public-api \
    --openapi-spec=$YAML_PATH \
    --backend-auth-service-account=public-api@real-games-304517.iam.gserviceaccount.com && \
gcloud api-gateway gateways update public-api-gateway \
    --location us-central1 \
    --api-config="$API_CONFIG" \
    --api=public-api