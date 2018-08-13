#!/usr/bin/env bash
set -ex

desired_count="$1"

aws autoscaling update-auto-scaling-group \
    --auto-scaling-group-name notejam \
    --min-size "$desired_count" \
    --max-size "$desired_count"
