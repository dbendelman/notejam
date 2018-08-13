#!/usr/bin/env bash
set -ex

# Find all app instance IDs:
target_group="$(aws elbv2 describe-target-groups --names "notejam" | jq -r '.TargetGroups[0].TargetGroupArn')"
instance_ids=( $(aws elbv2 describe-target-health --target-group-arn "$target_group" | jq -r '.TargetHealthDescriptions | map(.Target.Id) | join(" ")') )
instance_count=${#instance_ids[@]}

for instance_id in "${instance_ids[@]}"; do

    # Get the instance's DNS:
	instance_dns="$(aws ec2 describe-instances --instance-ids "$instance_id" | jq -r '.Reservations[0].Instances[0].PublicDnsName' 2>/dev/null)"
	[ -n "$instance_dns" ] ||
		( echo >&2 "FATAL: Failed to retrieve the public DNS of instance $instance_id."; return 1 )

    # Deploy the app:
    echo ">>> Deploying app on $instance_id ( $instance_dns )"
    ssh \
        -o "StrictHostKeyChecking no" \
        -o "UserKnownHostsFile /dev/null" \
        ubuntu@$instance_dns \
            deploy

done
