public class LeadHandler {
    //1.	Write an Apex trigger to automatically create a Task whenever a new Lead is created.
    public static void createTaskAfterLeadGenrated(List<Lead> newRecords){
        List<Task> bulkTaskInsert= new List<Task>(); 
        for(Lead record: newRecords){
            Task t= new Task();
            t.WhoId=record.id;
            t.Status='Pending';
            t.Description='Task created for lead '+record.company;
            t.Priority='High';
            t.ActivityDate=System.today()+7;
            t.Subject='Task created to take follow up for lead '+record.company;
            bulkTaskInsert.add(t);
        } 
        
        if(!bulkTaskInsert.isEmpty()){
            insert bulkTaskInsert;
        }
    }
}