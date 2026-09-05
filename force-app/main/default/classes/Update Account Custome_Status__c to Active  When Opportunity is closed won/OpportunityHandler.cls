 //4.	Write an Apex trigger to update the Account's Customer_Status__c to "Active" when an Opportunity is closed-won.
public  class OpportunityHandler {
    
    public static void updateAccountCustStatusAfterOppClosedWon(List<Opportunity> updateRecord, Map<Id, Opportunity> oldRecords){
        Set<Id> accountIds= new Set<Id> ();
        System.debug(updateRecord);
        for(Opportunity record:updateRecord){
            if(record.StageName=='Closed Won' ){
                accountIds.add(record.AccountId);
            }
        }
        System.debug(accountIds);
        
        if(!accountIds.isEmpty()){
            List<Account> bulkAccountUpdate = new List<Account>();
            for(Account acc:[SELECT id, name, Customer_Status__c FROM Account WHERE id IN: accountIds AND Customer_Status__c!='Active']){
                System.debug(acc);
                acc.Customer_Status__c='Active';
                bulkAccountUpdate.add(acc);
                System.debug(acc);
            }
           System.debug(bulkAccountUpdate);
            if(!bulkAccountUpdate.isEmpty()){
                update bulkAccountUpdate;
            }
        }
    }
}