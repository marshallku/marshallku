#!/bin/bash
message=''

parse_args() {
    case "$1" in
    -m | --message)
        message="$2"
        ;;
    esac
}

while [[ "$#" -ge 2 ]]; do
    parse_args "$1" "$2"
    shift
    shift
done

curl \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"$message\"}" \
    $DISCORD_WEBHOK_URI
