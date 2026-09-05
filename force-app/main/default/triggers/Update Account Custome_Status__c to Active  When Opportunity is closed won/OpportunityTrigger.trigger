trigger OpportunityTrigger on Opportunity (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
      OpportunityHandler.updateAccountCustStatusAfterOppClosedWon(Trigger.new, Trigger.oldMap);
      
    }
}