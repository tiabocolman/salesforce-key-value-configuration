@isTest
private class OrgConfigurationTest {
    
    // Constants
    private static final String GENERIC_KEY = 'Key_Random';
    private static final String CONFIG_STRING_VALUE = 'String_Value';
    private static final String CONFIG_STRING_OTHER_VALUE = 'String_Other_Value';
    private static final String STRING_DEFAULT = 'String_Default';
    private static final Integer INTEGER_DEFAULT = 20;
    private static final Decimal DECIMAL_DEFAULT = 11.11;
    private static final Double DOUBLE_DEFAULT = 66.66;
    private static final Date DATE_DEFAULT = Date.newInstance(2020, 6, 1);
    private static final Datetime DATETIME_DEFAULT = Datetime.newInstanceGMT(2020, 6, 1, 16, 10, 0);
    private static final Boolean BOOLEAN_DEFAULT = false;
    private static final List<String> LIST_DEFAULT = new List<String>{'x', 'y', 'z'};
    private static final Set<String> SET_DEFAULT = new Set<String>{'x', 'y', 'z'};
    private static final Map<String, String> MAP_DEFAULT = new Map<String, String>{'k1' => 'v1', 'k2' => 'v2'};
    // Single quoted map to force an exception
    private static final String WRONG_MAP = '{\'k1\':\'v1\',\'k2\':\'v2\',\'k3\':\'v3\'}';
    // Types
    private static final String DATE_TIME_FORMAT = 'yyyy-MM-dd HH:mm:ss';
    private static final String STRING_CONSTANT = 'String';
    private static final String LIST_STRING = 'List<String>';
    private static final String SET_STRING = 'Set<String>';
    private static final String MAP_STRING = 'Map<String,String>';
    
    @isTest static void testGetStringValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            String value = config.getStringValue(OrgConfigurationSelectorStub.KEY_STRING, STRING_DEFAULT);
        Test.stopTest();
        Assert.areEqual(OrgConfigurationSelectorStub.STRING_VALUE, value, 'String value retrieved incorrectly');
    }
    
    @isTest static void testGetStringDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            String value = config.getStringValue(OrgConfigurationSelectorStub.KEY_STRING, STRING_DEFAULT);
        Test.stopTest();
        Assert.areEqual(STRING_DEFAULT, value, 'Default String value retrieved incorrectly');
    }
    
    @isTest static void testGetIntegerValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Integer value = config.getIntegerValue(OrgConfigurationSelectorStub.KEY_INTEGER, INTEGER_DEFAULT);
        Test.stopTest();
        Assert.areEqual(OrgConfigurationSelectorStub.INTEGER_VALUE, value, 'Integer value retrieved incorrectly');
    }
    
    @isTest static void testGetIntegerDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Integer value = config.getIntegerValue(OrgConfigurationSelectorStub.KEY_INTEGER, INTEGER_DEFAULT);
        Test.stopTest();
        Assert.areEqual(INTEGER_DEFAULT, value, 'Default Integer value retrieved incorrectly');
    }
    
    @isTest static void testGetDecimalValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Double value = config.getDecimalValue(OrgConfigurationSelectorStub.KEY_DECIMAL, DECIMAL_DEFAULT);
        Test.stopTest();
        Assert.areEqual(OrgConfigurationSelectorStub.DECIMAL_VALUE, value, 'Decimal value retrieved incorrectly');
    }
    
    @isTest static void testGetDecimalDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Double value = config.getDecimalValue(OrgConfigurationSelectorStub.KEY_DECIMAL, DECIMAL_DEFAULT);
        Test.stopTest();
        Assert.areEqual(DECIMAL_DEFAULT, value, 'Default Decimal value retrieved incorrectly');
    }
    
    @isTest static void testGetDoubleValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Double value = config.getDoubleValue(OrgConfigurationSelectorStub.KEY_DOUBLE, DOUBLE_DEFAULT);
        Test.stopTest();
        Assert.areEqual(OrgConfigurationSelectorStub.DOUBLE_VALUE, value, 'Double value retrieved incorrectly');
    }
    
    @isTest static void testGetDoubleDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Double value = config.getDoubleValue(OrgConfigurationSelectorStub.KEY_DOUBLE, DOUBLE_DEFAULT);
        Test.stopTest();
        Assert.areEqual(DOUBLE_DEFAULT, value, 'Default Double value retrieved incorrectly');
    }
    
    @isTest static void testGetDateValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Date value = config.getDateValue(OrgConfigurationSelectorStub.KEY_DATE, String.valueOf(DATE_DEFAULT));
        Test.stopTest();
        Assert.areEqual(OrgConfigurationSelectorStub.DATE_VALUE, value, 'Date value retrieved incorrectly');
    }
    
    @isTest static void testGetDateDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Date value = config.getDateValue(OrgConfigurationSelectorStub.KEY_DATE, String.valueOf(DATE_DEFAULT));
        Test.stopTest();
        Assert.areEqual(DATE_DEFAULT, value, 'Default date value retrieved incorrectly');
    }
    
    @isTest static void testGetDatetimeValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Datetime value = config.getDatetimeValue(OrgConfigurationSelectorStub.KEY_DATETIME, DATETIME_DEFAULT.formatGmt(DATE_TIME_FORMAT));
        Test.stopTest();
        Assert.areEqual(OrgConfigurationSelectorStub.DATETIME_VALUE, value, 'Datetime value retrieved incorrectly');
    }
    
    @isTest static void testGetDatetimeDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Datetime value = config.getDatetimeValue(OrgConfigurationSelectorStub.KEY_DATETIME, DATETIME_DEFAULT.formatGmt(DATE_TIME_FORMAT));
        Test.stopTest();
        Assert.areEqual(DATETIME_DEFAULT, value, 'Default Datetime value retrieved incorrectly');
    }
    
    @isTest static void testGetBooleanValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Boolean value = config.getBooleanValue(OrgConfigurationSelectorStub.KEY_BOOLEAN, BOOLEAN_DEFAULT);
        Test.stopTest();
        Assert.areEqual(OrgConfigurationSelectorStub.BOOLEAN_VALUE, value, 'Boolean value retrieved incorrectly');
    }
    
    @isTest static void testGetBooleanDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Boolean value = config.getBooleanValue(OrgConfigurationSelectorStub.KEY_BOOLEAN, BOOLEAN_DEFAULT);
        Test.stopTest();
        Assert.areEqual(BOOLEAN_DEFAULT, value, 'Default Boolean value retrieved incorrectly');
    }
    
    @isTest static void testGetListValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            List<String> value = config.getListStringValue(OrgConfigurationSelectorStub.KEY_LIST_STRING, LIST_DEFAULT);
        Test.stopTest();
        // Checking the list size seems good enough
        Assert.areEqual(OrgConfigurationSelectorStub.LIST_VALUE_SIZE, value.size(), 'List value retrieved incorrectly');
    }
    
    @isTest static void testGetListDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            List<String> value = config.getListStringValue(OrgConfigurationSelectorStub.KEY_LIST_STRING, LIST_DEFAULT);
        Test.stopTest();
        // Checking the list size seems good enough
        Assert.areEqual(LIST_DEFAULT.size(), value.size(), 'Default list value retrieved incorrectly');
    }
    
    @isTest static void testGetSetValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Set<String> value = config.getSetStringValue(OrgConfigurationSelectorStub.KEY_SET_STRING, SET_DEFAULT);
        Test.stopTest();
        // Checking the set size seems good enough
        Assert.areEqual(OrgConfigurationSelectorStub.SET_VALUE_SIZE, value.size(), 'Set value retrieved incorrectly');
    }
    
    @isTest static void testGetSetDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Set<String> value = config.getSetStringValue(OrgConfigurationSelectorStub.KEY_SET_STRING, SET_DEFAULT);
        Test.stopTest();
        // Checking the set size seems good enough
        Assert.areEqual(SET_DEFAULT.size(), value.size(), 'Default set value retrieved incorrectly');
    }
    
    @isTest static void testGetMapValue() {
        OrgConfiguration config = new OrgConfiguration();
        // Stub the selector to return a test configuration record
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub());
        Test.startTest();
            Map<String, String> value = config.getMapStringValue(OrgConfigurationSelectorStub.KEY_MAP_STRING, MAP_DEFAULT);
        Test.stopTest();
        // Checking the map size seems good enough
        Assert.areEqual(OrgConfigurationSelectorStub.MAP_VALUE_SIZE, value.size(), 'Map value retrieved incorrectly');
    }
    
    @isTest static void testGetMapDefaultValue() {
        // Do not stub in order to get the default value (since no record should be there)
        OrgConfiguration config = new OrgConfiguration();
        Test.startTest();
            Map<String, String> value = config.getMapStringValue(OrgConfigurationSelectorStub.KEY_MAP_STRING, MAP_DEFAULT);
        Test.stopTest();
        // Checking the map size seems good enough
        Assert.areEqual(MAP_DEFAULT.size(), value.size(), 'Default map value retrieved incorrectly');
    }
    
    @isTest static void testCacheMap() {
        // To test the cache we'll have to stubs each returning a configuration record with same key and different value
        // The idea is that even though both instances are using different stubs they both should get the same result
        // As the value will be kept on the cached map
        // Create maps to pass to the stubs
        Map<String, String> valuesOne = new Map<String, String>{GENERIC_KEY => CONFIG_STRING_VALUE};
        Map<String, String> types = new Map<String, String>{GENERIC_KEY => STRING_CONSTANT};
        // First instance
        OrgConfiguration configOne = new OrgConfiguration();
        // Set the stub
        configOne.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub(valuesOne, types));
        // Second instance
        OrgConfiguration configTwo = new OrgConfiguration();
        // Create a new value map to pass to the stub
        Map<String, String> valuesTwo = new Map<String, String>{GENERIC_KEY => CONFIG_STRING_OTHER_VALUE};
        // Set the stub
        configTwo.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub(valuesTwo, types));
        Test.startTest();
            String valueOne = configOne.getStringValue(GENERIC_KEY, STRING_DEFAULT);
            String valueTwo = configTwo.getStringValue(GENERIC_KEY, STRING_DEFAULT);
        Test.stopTest();
        Assert.areEqual(CONFIG_STRING_VALUE, valueOne, 'String value retrieved incorrectly for first instance');
        Assert.areEqual(CONFIG_STRING_VALUE, valueTwo, 'String value retrieved incorrectly for second instance');
    }

    @isTest static void testExceptionOnDeserialize() {
        // Force an exception when deserializing a map value
        Map<String, String> values = new Map<String, String>{GENERIC_KEY => WRONG_MAP};
        Map<String, String> types = new Map<String, String>{GENERIC_KEY => MAP_STRING};
        // First instance
        OrgConfiguration config = new OrgConfiguration();
        // Set the stub
        config.configSelector = (OrgConfigurationSelector) Test.createStub(OrgConfigurationSelector.class, new OrgConfigurationSelectorStub(values, types));
        Test.startTest();
            Map<String, String> value = config.getMapStringValue(GENERIC_KEY, MAP_DEFAULT);
        Test.stopTest();
        // The default value should be returned as a result of the incorrectly formattted value 
        Assert.areEqual(MAP_DEFAULT.size(), value.size(), 'Default value was not returned on a forced exception');
    }
}