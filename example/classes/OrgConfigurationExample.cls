/**
 * Example class to demonstrate how the utility can be used
 */
public without sharing class OrgConfigurationExample extends OrgConfiguration {

    // Keys for the configurations this class handles
    // Notice that multiple classes can be created extending OrgConfiguration
    // To logically group a set of configuration keys
    private static final String KEY_STRING = 'String_Example';
    private static final String KEY_DECIMAL = 'Decimal_Example';
    private static final String KEY_MAP = 'Map_Example';

    // Default values
    private static final String DEFAULT_STRING = 'Defaut String';
    private static final Decimal DEFAULT_DECIMAL = 8.5;
    private static final Map<String,String> DEFAULT_MAP = new Map<String,String>{'Key' => 'Some value'};
    
    public OrgConfigurationExample() {
        super();
    }

    // Notice how none of the methods below have any parameters

    public String getStringExampleConfig() {
        return getStringValue(KEY_STRING, DEFAULT_STRING);
    }

    public Decimal getDecimalExampleConfig() {
        return getDecimalValue(KEY_DECIMAL, DEFAULT_DECIMAL);
    }

    public Map<String, String> getMapExampleConfig() {
        return getMapStringValue(KEY_MAP, DEFAULT_MAP);
    }
}