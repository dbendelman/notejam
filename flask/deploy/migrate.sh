#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd )"
set -ex

cd "$ROOT_DIR"
git_branch="$(git branch 2>/dev/null | grep '*' | grep -v "detached from" | awk '{print $2}')"
cd -
image_name=$REGISTRY_SERVER/dbendelman/notejam

# Create the database:
docker run -t --rm \
    --name=create-database \
    mariadb:10.3.8 \
        mysql -h $MYSQL_HOST -u root -ppassword -e \
            "CREATE DATABASE IF NOT EXISTS notejam;"

# Migrate models:
docker run -t --rm \
    --name=migrate-database \
    -e MYSQL_HOST=$MYSQL_HOST \
    $image_name:$git_branch \
        python db.py
