#!/usr/bin/env bash

function array2json {
    local arr=$1
    printf '%s\n' "${arr[@]}" | jq -R . | jq -s . | jq "del(.[] | select (. == \"\"))"
}

export DASH_NETWORK_NAME=$([ "$DASH_TESTNET" == 1 ] && echo "testnet" || echo "livenet")
export API_ENABLE_CACHE=$([ "$API_ENABLE_CACHE" == 1 ] && echo "true" || echo "false")

export API_LIMIT_DISABLE=$([ "$API_LIMIT_ENABLE" == 1 ] && echo "false" || echo "true")
export API_LIMIT_WHITELIST_JSON=$(array2json $API_LIMIT_WHITELIST)
export API_LIMIT_BLACKLIST_JSON=$(array2json $API_LIMIT_BLACKLIST)

export DASH_ZMQ_HOST=$([ "$DASH_ZMQ_HOST" == "" ] && echo "$DASH_RPC_HOST" || echo "$DASH_ZMQ_HOST")

mkdir -p /root/.dashcore
envsubst < ./dashcore-node.template.json > /root/.dashcore/dashcore-node.json
./node_modules/.bin/dashcore-node start