#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd )"
set -ex

cd "$ROOT_DIR"
git_commit="$(git log -n 1 --pretty=format:'%h')"
cd -
image_name=$REGISTRY_SERVER/dbendelman/notejam

docker run -t --rm $image_name:$git_commit python tests.py
