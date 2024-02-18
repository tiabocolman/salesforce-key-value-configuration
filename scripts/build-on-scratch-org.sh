#!/bin/bash
# Single parameter expected, which should be your Dev Hub alias
DEV_HUB_ORG_ALIAS=$1
SCRATCH_ORG_ALIAS="key-value-config"
# Exit if not provided
if [ -z "$1" ]
  then
    echo "Please provide an alias for your Dev Hub Org"
    exit 1
fi
# Set
echo "Creating scratch org..."
sf org create scratch \
  --target-dev-hub $DEV_HUB_ORG_ALIAS \
  --alias $SCRATCH_ORG_ALIAS \
  --duration-days 1 \
  --definition-file config/project-scratch-def.json
# 
echo "Deploying metadata..."
sf project deploy start \
  --target-org $SCRATCH_ORG_ALIAS \
  --source-dir sfdx-source \
  --source-dir example
#
echo "Running tests..."
sf apex run test \
  --target-org $SCRATCH_ORG_ALIAS \
  --result-format human \
  --class-names OrgConfigurationTest \
  --synchronous \
  --code-coverage