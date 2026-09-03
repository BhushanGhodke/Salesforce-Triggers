public class ContactHandler {
 // 2.	Write a trigger to count the total Contacts related to an Account and update a custom field Total_Contacts__c.
    public static void rollUpContactCountToAccountAfterInsert(List<Contact> newRecords){
        Set<Id> accountIds = new Set<Id> ();
        List<Account> bulkAccountUpdate = new List<Account>();
        for(Contact record:newRecords){
            if(record.accountId!=null){
                accountIds.add(record.accountId);
            }
        }
        
        if(!accountIds.isEmpty()){
            Map<Id, Integer> accIdConCountMap= new Map<Id, Integer> ();
            for(AggregateResult result:[SELECT count(id)conCount, accountId FROM Contact WHERE accountId IN :accountIds GROUP BY accountId]){
                    accIdConCountMap.put((Id)result.get('accountId'),(Integer) result.get('conCount')); 
            }
            
            for(Account acc:[SELECT id, name,Total_No_Of_Contact__c FROM account WHERE id IN: accountIds ]){
                acc.Total_No_Of_Contact__c=accIdConCountMap.get(acc.id);
                bulkAccountUpdate.add(acc);
            }
            if(!bulkAccountUpdate.isEmpty()){
                update bulkAccountUpdate;
            }
        }
    }
    
    public static void rollUpContactCountToAccountAfterUpdate(List<Contact> updateRecords, Map<Id, Contact > oldRecords){
        Set<Id> accountIds= new Set<Id>();
        for(Contact record:updateRecords){
            if(record.AccountId!=null && record.AccountId!=oldRecords.get(record.Id).accountId ){
                accountIds.add(record.AccountId);
                accountIds.add(oldRecords.get(record.id).accountId);
            }    
        }
        if(!accountIds.isEmpty()){
            List<Account> bulkUpdateAccount = new List<Account>(); 
            Map<Id,Integer> accIdConCountMap= new Map<Id, Integer>();
            for(AggregateResult result:[SELECT count(id)conCount, accountId FROM Contact WHERE accountId IN: accountIds GROUP BY accountId]){
                   accIdConCountMap.put((Id)result.get('accountId'), (Integer)result.get('conCount'));   
            }
            
            for(Account acc:[SELECT id, name,Total_No_Of_Contact__c FROM Account WHERE id IN: accountIds ]){
                acc.Total_No_Of_Contact__c=accIdConCountMap.get(acc.Id);
                bulkUpdateAccount.add(acc);
            }
            if(!bulkUpdateAccount.isEmpty()){
                update bulkUpdateAccount;
            }
        }
        
    }
    
    public static void rollUpContactCountToAccountAfterDelete(List<Contact> oldRecords){
        Set<Id> accountIds= new Set<Id>();
         List<Account> bulkAccountUpdate = new List<Account>();
        System.debug(oldRecords);
        for(Contact record:oldRecords){
           System.debug(record);
            accountIds.add(record.AccountId);
        }
        
        if(!accountIds.isEmpty()){
              Map<Id, Integer> accIdConCountMap= new Map<Id, Integer> ();
            for(AggregateResult result:[SELECT count(id)conCount, accountId FROM Contact WHERE accountId IN :accountIds GROUP BY accountId]){
                    accIdConCountMap.put((Id)result.get('accountId'),(Integer) result.get('conCount')); 
                System.debug(result);
            }
           System.debug(accIdConCountMap);
            for(Account acc:[SELECT id, name,Total_No_Of_Contact__c FROM account WHERE id IN: accountIds ]){
                acc.Total_No_Of_Contact__c=accIdConCountMap.get(acc.id);
                System.debug(acc);
                bulkAccountUpdate.add(acc);
            }
            if(!bulkAccountUpdate.isEmpty()){
                update bulkAccountUpdate;
            }
            
        }
    }
}