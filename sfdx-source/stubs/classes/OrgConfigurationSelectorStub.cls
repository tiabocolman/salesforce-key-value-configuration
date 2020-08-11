/**
 * Stub class for OrgConfigurationSelector
 */
@isTest
public class OrgConfigurationSelectorStub implements StubProvider {

    // Suffix to add to the keys to avoid collisions with existing custom metadata records
    private static final String SUFFIX = String.valueOf(DateTime.now().getTime());
    // Key-Value pairs
    public static final String KEY_STRING = 'Key_String' + SUFFIX;
    public static final String STRING_VALUE = 'String_Value';
    public static final String KEY_INTEGER = 'Key_Integer' + SUFFIX;
    public static final Integer INTEGER_VALUE = 10;
    public static final String KEY_DECIMAL = 'Key_Decimal' + SUFFIX;
    public static final Decimal DECIMAL_VALUE = 99.99;
    public static final String KEY_DOUBLE = 'Key_Double' + SUFFIX;
    public static final Double DOUBLE_VALUE = 33.33;
    public static final String KEY_DATE = 'Key_Date' + SUFFIX;
    public static final Date DATE_VALUE = Date.newInstance(2019, 2, 10);
    public static final String KEY_DATETIME = 'Key_Datetime' + SUFFIX;
    public static final Datetime DATETIME_VALUE = Datetime.newInstanceGMT(2019, 2, 10, 12, 30, 0);
    public static final String KEY_BOOLEAN = 'Key_Boolean' + SUFFIX;
    public static final Boolean BOOLEAN_VALUE = true;
    public static final String KEY_LIST_STRING = 'Key_List_String' + SUFFIX;
    public static final String LIST_VALUE = '["a","b","c","a"]';
    public static final Integer LIST_VALUE_SIZE = 4;
    public static final String KEY_SET_STRING = 'Key_Set_String' + SUFFIX;
    public static final String SET_VALUE = '["a","b","c","d"]';
    public static final Integer SET_VALUE_SIZE = 4;
    public static final String KEY_MAP_STRING = 'Key_Map_String' + SUFFIX;
    public static final String MAP_VALUE = '{"k1":"v1","k2":"v2","k3":"v3"}';
    public static final Integer MAP_VALUE_SIZE = 3;
    
    private Map<String, String> configValues = new Map<String, String>{
        KEY_STRING => STRING_VALUE,
        KEY_INTEGER => String.valueOf(INTEGER_VALUE),
        KEY_DECIMAL => String.valueOf(DECIMAL_VALUE),
        KEY_DOUBLE => String.valueOf(DOUBLE_VALUE),
        KEY_DATE => String.valueOf(DATE_VALUE),
        KEY_DATETIME => DATETIME_VALUE.formatGmt(OrgConfiguration.DATE_TIME_FORMAT),
        KEY_BOOLEAN => String.valueOf(BOOLEAN_VALUE),
        KEY_LIST_STRING => LIST_VALUE,
        KEY_SET_STRING => SET_VALUE,
        KEY_MAP_STRING => MAP_VALUE
    };
    
    private Map<String, String> configTypes = new Map<String, String>{
        KEY_STRING => 'String',
        KEY_INTEGER => 'Integer',
        KEY_DECIMAL => 'Decimal',
        KEY_DOUBLE => 'Double',
        KEY_DATE => 'Date',
        KEY_DATETIME => 'Datetime',
        KEY_BOOLEAN => 'Boolean',
        KEY_LIST_STRING => 'List<String>',
        KEY_SET_STRING => 'Set<String>',
        KEY_MAP_STRING => 'Map<String,String>'
    };

    public OrgConfigurationSelectorStub() {
    }

    // Extra constructor to allow tests to pass custom values
    public OrgConfigurationSelectorStub(Map<String, String> values, Map<String, String> types) {
        configValues.putAll(values);
        configTypes.putAll(types);
    }
    
    private static final String GET_ORG_CONFIGURATION = 'getOrgConfiguration';
    
	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, 
        Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, 
        List<Object> listOfArgs) {
        // Only stubbed method
        if (GET_ORG_CONFIGURATION == stubbedMethodName) {
            String configName = String.valueOf(listOfArgs.get(0));
            Org_Configuration__mdt configRecord = new Org_Configuration__mdt();
            configRecord.DeveloperName = configName;
            configRecord.Value__c = configValues.get(configName);
            configRecord.Type__c = configTypes.get(configName);
            configRecord.Active__c = true;
            return configRecord;
        } else {
            return null;
        }
    }
}