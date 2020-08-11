/**
 * Selector class for Org_Configuration__mdt
 */
public without sharing class OrgConfigurationSelector {
    
    /**
     * Retrieves the Org Configuration record for a given configuration name (if active)
     * @param configName developer name of the configuration record we want to get
     * @return the corresponding record for that name or null if not found
     */
    public Org_Configuration__mdt getOrgConfiguration(String configName) {
        // No issue with doing queries individually since they do not count for SOQL limit
        List<Org_Configuration__mdt> configuration = [SELECT Value__c, Type__c FROM Org_Configuration__mdt
                                                      WHERE DeveloperName = :configName AND Active__c = true];
        return !configuration.isEmpty() ? configuration.get(0) : null;
    }
}