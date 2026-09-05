trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {

       if(Trigger.isafter && ( Trigger.isinsert || Trigger.isundelete)){
        ContactHandler.rollUpContactCountToAccountAfterInsert(Trigger.New);
    }
    
    if(Trigger.isafter && Trigger.isupdate){
        ContactHandler.rollUpContactCountToAccountAfterUpdate(Trigger.New, Trigger.OldMap);
    }
    
    if(Trigger.isafter && Trigger.isdelete){
        ContactHandler.rollUpContactCountToAccountAfterDelete(Trigger.Old);
    }
}