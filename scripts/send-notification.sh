#!/bin/bash
message=''

while [[ $# -gt 0 ]]; do
    case "$1" in
    -m | --message)
        message="$2"
        shift 2
        ;;
    *)
        echo "Unknown argument: $1"
        exit 1
        ;;
    esac
done

curl \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"$message\"}" \
    "$DISCORD_WEBHOOK_URI"
