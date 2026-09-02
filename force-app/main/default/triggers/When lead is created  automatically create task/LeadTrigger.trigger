trigger LeadTrigger on Lead (after insert) {
    //1.	Write an Apex trigger to automatically create a Task whenever a new Lead is created.
    if(Trigger.isafter && Trigger.isinsert){
       LeadHandler.createTaskAfterLeadGenrated(Trigger.new);
    }
}