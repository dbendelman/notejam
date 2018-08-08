#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd )"
set -ex

(
    cd "$ROOT_DIR"
    git_branch="$(git branch 2>/dev/null | grep '*' | grep -v "detached from" | awk '{print $2}')"
    image_name=$REGISTRY_SERVER/dbendelman/notejam

    docker run -t --rm $image_name:$git_branch python tests.py
)
