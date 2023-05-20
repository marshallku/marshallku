#!/bin/bash
if [[ $(git status --porcelain) ]]; then
    git config user.name github-actions[bot]
    git config user.email 41898282+github-actions[bot]@users.noreply.github.com
    git remote set-url origin https://x-access-token:$TOKEN@github.com/$REPOSITORY
    git add -A
    git commit -m "$MESSAGE"
    git push
fi
