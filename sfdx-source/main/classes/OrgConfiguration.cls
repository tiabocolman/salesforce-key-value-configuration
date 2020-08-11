/**
 * Class to access the general purpose key-value configuration on Org_Configuration__mdt
 * Introducing a new type of value will require the following steps
 * 1- Add a new picklist value in the field Type__c
 * 2- If necessary add a when statement on getValueFromRecord to deserialize/cast the value accordingly
 * 3- Add a private method like 
 *    private String get<YOUR_TYPE>Value(String configName, YOUR_TYPE defaultValue)
 *    similar to methods like getStringValue, getListStringValue, etc
 * It's worth noting that the value of these configurations shouldn't be more complex than a map of primitive data types
 * If more complex configuration is required, a new specific custom metadata type should be considered
 * Remember that the DeveloperName has a limit of 40 characters
 */
public virtual without sharing class OrgConfiguration {
    
    @testVisible
    private static final String DATE_TIME_FORMAT = 'yyyy-MM-dd HH:mm:ss';
    
    // Selector for Org Configuration, visible on tests for stubbing
    @testVisible
    private OrgConfigurationSelector configSelector {
        get {
            if (configSelector == null) {
                configSelector = new OrgConfigurationSelector();
            }
            return configSelector;
        }
        set;
    }

    /**
     * We keep a map of already retrieved values
     * The key being the developer name of the Org Configuration record
     * I've decided to make the keys case-insensitive
     * so the keys of this map will be lowercased to avoid conflicts
     */
    private static Map<String, Object> cachedConfiguration;
    
    public OrgConfiguration() {
        cachedConfiguration = new Map<String, Object>();
    }
    
    /**
     * Returns the value of the configuration record appropriately cast based on its type
     * This is needed because a JSON deserialization needs to happen for the cast to work on non primitive data types
     * If an exception happens, the default value will be returned
     * @param configuration custom metadata record
     * @return the corresponding configuration value, cast to the correct type, or the default value if an excpetion occurs
     */
    private Object getValueFromRecord(Org_Configuration__mdt configuration, Object defaultValue) {
        Object value;
        try {
            // Using string literals as it seemed unnecessary to define an enum
            switch on configuration.Type__c {
                when 'List<String>' {
                    // List values are expected to be defined as JSON arrays
                    // e.g ["firstValue", "secondValue"]
                    value = (List<String>) JSON.deserialize(configuration.Value__c, List<String>.class);
                }
                when 'Set<String>' {
                    // Set values are expected to be defined as JSON arrays, with no repeated value
                    // e.g ["firstValue", "secondValue"]
                    value = (Set<String>) JSON.deserialize(configuration.Value__c, Set<String>.class);
                }
                when 'Map<String,String>' {
                    // Map values are expected to be defined as JSON objects
                    // e.g {"key_1":"value_1","key_2":"value_2"}
                    value = (Map<String, String>) JSON.deserialize(configuration.Value__c, Map<String, String>.class);
                }
                when else {
                    value = configuration.Value__c;
                }
            }
        } catch (Exception e) {
            // If an exception happens, return the default value
            value = defaultValue;
        }
        return value;
    }
    
    /**
     * Returns true if the configuration record has a value
     * @param configuration custom metadata record
     * @return true if the record is not null and has some sort of value populated
     */
    private Boolean hasValue(Org_Configuration__mdt configuration) {
        return configuration != null && String.isNotBlank(configuration.Value__c);
    }
    
    /**
     * Tries to obtain the configuration value from the custom metadata record
     * and assigns the given default value if not found
     * @param configName custom metadata record
     * @param defaultValue value to return if no configuration record is found
     * @return object representing the value on the configuration record or the given default
     */
    private Object getValue(String configName, Object defaultValue) {
        Object value;
        String configNameKey = configName.toLowerCase();
        if (cachedConfiguration.get(configNameKey) == null) {
            Org_Configuration__mdt configuration = configSelector.getOrgConfiguration(configName);
            value = hasValue(configuration) ? getValueFromRecord(configuration, defaultValue) : defaultValue;
            cachedConfiguration.put(configNameKey, value);
        } else {
            value = cachedConfiguration.get(configNameKey);
        }
        return value;
    }
    
    /**
     * Here goes the generic methods that return the configuration values cast to the appropriate types
     * They all accept a default value to handle scenarios where the custom metadata records are not present in the Org
     * Making them test visible for unit test them
     */
    
    @testVisible
    protected String getStringValue(String configName, String defaultValue) {
        return (String) getValue(configName, defaultValue);
    }
    
    @testVisible
    protected Integer getIntegerValue(String configName, Integer defaultValue) {
        return Integer.valueOf(getValue(configName, defaultValue));
    }
    
    @testVisible
    protected Decimal getDecimalValue(String configName, Decimal defaultValue) {
        return Decimal.valueOf(Double.valueOf(getValue(configName, defaultValue)));
    }
    
    @testVisible
    protected Double getDoubleValue(String configName, Double defaultValue) {
        return Double.valueOf(getValue(configName, defaultValue));
    }
    
    // Date values are expected with the format yyyy-MM-dd
    @testVisible
    protected Date getDateValue(String configName, String defaultValue) {
        return Date.valueOf((String) getValue(configName, defaultValue));
    }
    
    // Datetime values are expected with the format yyyy-MM-dd HH:mm:ss and in GMT
    // Both for the configuration records and the default values
    @testVisible
    protected Datetime getDateTimeValue(String configName, String defaultValue) {
        return Datetime.valueOfGMT((String) getValue(configName, defaultValue));
    }
    
    @testVisible
    protected Boolean getBooleanValue(String configName, Boolean defaultValue) {
        return Boolean.valueOf(getValue(configName, defaultValue));
    }
    
    @testVisible
    protected List<String> getListStringValue(String configName, List<String> defaultValue) {
        return (List<String>) getValue(configName, defaultValue);
    }
    
    @testVisible
    protected Set<String> getSetStringValue(String configName, Set<String> defaultValue) {
        return (Set<String>) getValue(configName, defaultValue);
    }
    
    @testVisible
    protected Map<String, String> getMapStringValue(String configName, Map<String, String> defaultValue) {
        return (Map<String, String>) getValue(configName, defaultValue);
    }
}