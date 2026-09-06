//5.Write a trigger to prevent an Opportunity from being moved to Closed Won if it has no Opportunity Products.
trigger OpportunityPreventCloseWonTrigger on Opportunity (before update) {

    if(Trigger.isbefore && Trigger.isupdate){
        OpportunityPreventCloseWonHandler.OpportunityPreventCloseWonIfProductNotPresent(Trigger.new, Trigger.OldMap);
    }
}