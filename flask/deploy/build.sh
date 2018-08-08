#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd )"
set -ex

(
    cd "$ROOT_DIR"
    git_commit="$(git log -n 1 --pretty=format:'%h')"
    git_branch="$(git branch 2>/dev/null | grep '*' | grep -v "detached from" | awk '{print $2}')"
    image_name=$REGISTRY_SERVER/dbendelman/notejam

    docker build -t $image_name .
    docker tag $image_name:latest $image_name:$git_commit
    docker tag $image_name:latest $image_name:$git_branch
)
