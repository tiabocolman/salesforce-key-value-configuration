# Key Value Configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Custom Metadata Type (CMT) with a thin Apex wrapper to be used as a generic key-value configuration for an Org.

## Motivation

When building customizations on top of the Salesforce platform there are situations where you want to be able to customize values included in your business logic and don't have to hard code them, but at the same time they don't justify the creation of a CMT specific for them.

## Approach

A way to handle this situation is having a generic CMT to act as a sort of key-value configurations for the Org. Each record represents a key-value pair, the key being the `DeveloperName` of the record and its value the custom field `Value__c`. 
In order to represent different types of values with a single field, a field `Type__c` specifies the data type of the value, which it's used by the Apex code in `OrgConfiguration` to cast/parse the value accordingly.

## Deploy and Test

Prerequisite: having sfdx cli installed

The script `scripts/build-on-scratch-org.sh` can be used to push the metadata to a new scratch org to test the functionality; unit tests are also run as part of the script. A single required parameter needs to be included, which should be the alias for a Dev Hub already authenticatd on your sfdx cli.

```bash
sh scripts/build-on-scratch-org.sh <YOUR_DEV_HUB_ORG_ALIAS>
```

The new scratch org will be created with the name `key-value-config`.

## Resources