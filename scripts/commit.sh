#!/bin/bash
if [[ -z $(git status --porcelain) ]]; then
    echo 'Nothing to commit'
    exit 0
fi

message='Automated commit with github actions'

while [[ $# -gt 0 ]]; do
    case "$1" in
    -m)
        message="$2"
        shift 2
        ;;
    *)
        echo "Unknown argument: $1"
        exit 1
        ;;
    esac
done

git config user.name github-actions[bot]
git config user.email 41898282+github-actions[bot]@users.noreply.github.com
git add -A
git commit -m "$message"
# Please give write permission to github actions at the link below.
# echo "${{ github.server_url }}/${{ github.repository }}/settings/actions"
git push
