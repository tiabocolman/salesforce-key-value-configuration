# Salesforce Key Value Configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![LinkedIn](https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555)](https://linkedin.com/in/santiago-colman-ab51474b/)

Custom Metadata Type (CMT) with a thin Apex wrapper to be used as a generic key-value configuration for an Org.

## Motivation

When building customizations on top of the Salesforce platform there are situations where you want to be able to customize values included in your business logic and don't have to hard code them, but at the same time they don't justify the creation of a CMT specific for them.

## Approach

A way to handle this situation is having a generic CMT to act as a sort of key-value configuration for the Org. Each record represents a key-value pair, the key being the `DeveloperName` of the record and its value the custom field `Value__c`. 
In order to represent different types of values with a single field, a field `Type__c` specifies the data type of the value, which it's used by the Apex code in `OrgConfiguration` to cast/parse the value accordingly.
Additionally the field `Active__c` is used to determine if we should read this configuration from the metadata record or not; the methods in `OrgConfiguration` expects a default value to be passed, which will be returned if a record for a given key is inactive.

### When can this be used

* If you have a constant with a simple data type that you want to be able to configure
* If a configuration value is pretty isolated and doesn't have a logical relation with others

### When it should not be used

* If you have multiple values that can be logically associated into its own CMT
* If you have to represent a configuration value with a complex structure

## Metadata

The CMT definition and Apex wrapper are located inside `sfdx-source/main/`; an Apex Stub and Unit test can be found in the folders `sfdx-source/stubs/` and `sfdx-source/tests/` 

### Supported data types

The following data types are currently supported

* String
* Decimal
* Double
* Date
* Datetime
* Boolean
* List<String>
* Set<String>
* Map<String,String>

## Usage

Key-value pairs need to be defined as custom metadata records

* `Label`: any label that helps identify the record (recommended to be a readable version of the key)
* `DeveloperName`: this will be the key that it's used to identify the record
* `Value__c`: the actual value for the configuration key
* `Type__c`: data type of the value
* `Active__c`: flag to specify if the value on the record should be used or not

### Formatting

Some data types require a particular formatting to be correctly parsed

#### Date

Date values are expected with the format `yyyy-MM-dd`: `2020-08-11`

#### Datetime

Datetime values are expected with the format `yyyy-MM-dd HH:mm:ss` and in GMT: `2020-08-11 15:46:00`

#### List<String>

List values are expected to be defined as JSON arrays: `["firstValue", "secondValue"]`

#### Set<String>

Set values are expected to be defined as JSON arrays, with no repeated values: `["firstValue", "secondValue"]`

#### Map<String, String>

Map values are expected to be defined as JSON objects: `{"key_1":"value_1","key_2":"value_2"}`

### Code

Once the records are defined, its values can be accessed by creating classes extending `OrgConfiguration` and exposing public methods to retrieve their values using the `protected` methods in `OrgConfiguration`, depending on the data type of the value.

For example, for an `Integer` configuration value with a key `INTEGER_CONFIG`, you can create a class like the following

```java
public without sharing class OrgConfigurationExtension extends OrgConfiguration {
    public OrgConfigurationExtension() {
        super();
    }

    // The first parameter is the DeveloperName of the record we want
    // The second parameter is the default value in case the record is inactive
    public Integer getIntegerConfig() {
        return getIntegerValue('INTEGER_CONFIG', 10);
    }
}
```

An example of this can be found in `example/`; it contains three records, each with different data types, and a class `OrgConfigurationExample` exposing methods to access this values.

## How to extend 

If you need a data type that's not defined already, it can be supported by following these steps:

1. Add a new picklist value in the field Type__c
1. If necessary add a when statement on the method `getValueFromRecord` in `OrgConfiguration` to deserialize/cast the value accordingly
1. Add a private method for the type, similar to the existing `getStringValue`, `getListStringValue`, etc.
```java
private String get<YOUR_TYPE>Value(String configName, <YOUR_TYPE> defaultValue)
```

## Deploy and Test

Prerequisite: having sfdx cli installed

The script `scripts/build-on-scratch-org.sh` can be used to push the metadata to a new scratch org to test the functionality; unit tests are also run as part of the script. A single required parameter needs to be included, which should be the alias for a Dev Hub already authenticatd on your sfdx cli.

```bash
sh scripts/build-on-scratch-org.sh <YOUR_DEV_HUB_ORG_ALIAS>
```

The new scratch org will be created with the name `key-value-config`.

## Contact

Santiago Colman - tiabocolman@gmail.com