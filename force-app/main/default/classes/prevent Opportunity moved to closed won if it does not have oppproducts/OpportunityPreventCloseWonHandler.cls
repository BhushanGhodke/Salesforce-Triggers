//5.	Write a trigger to prevent an Opportunity from being moved to Closed Won if it has no Opportunity Products.
public class OpportunityPreventCloseWonHandler {

    public static void OpportunityPreventCloseWonIfProductNotPresent(List<Opportunity> newRecords, Map<Id, Opportunity> oldRecords){
        Set<Id> oppid= new Set<Id>();
        for(Opportunity record:newRecords){
            if(record.stageName!= oldRecords.get(record.id).stageName && record.stageName=='Closed Won'){
                oppid.add(record.id);
            }
        }
        if(!oppid.isEmpty()){
        List<Opportunity> oppList=[SELECT id, name, stageName,(SELECT id, name FROM OpportunityLineItems) FROM Opportunity WHERE id IN :oppid ];
        System.debug(oppList);
        Map<Id, Integer> oppIdToProductCountMap= new Map<Id, Integer>();
        for(Opportunity opp:oppList){
            oppIdToProductCountMap.put(opp.id, opp.OpportunityLineItems.size());
        }
        System.debug(oppIdToProductCountMap);
        
        for(Opportunity opp: newRecords){
            if(oppIdToProductCountMap.get(opp.id)==0){
                opp.StageName.addError('Error!! Porduct Must be add to change status as closed won ');
                System.debug('error executed');
            }
        }
        }
       
    }
}

//OpportunityPreventCloseWonTrigger: execution of BeforeUpdate caused by: System.FinalException: SObject row does not allow errors 
//Class.OpportunityPreventCloseWonHandler.OpportunityPreventCloseWonIfProductNotPresent: line 17, column 1 Trigger.OpportunityPreventCloseWonTrigger: line 4, column 1
//