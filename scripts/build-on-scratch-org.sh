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
sfdx force:org:create -v $DEV_HUB_ORG_ALIAS -a $SCRATCH_ORG_ALIAS -d 1 -f config/project-scratch-def.json
# 
echo "Deploying metadata..."
sfdx force:source:push -u $SCRATCH_ORG_ALIAS
#
echo "Running tests..."
sfdx force:apex:test:run -u $SCRATCH_ORG_ALIAS -r human -n OrgConfigurationTest -y -c