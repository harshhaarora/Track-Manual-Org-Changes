global class AuditTrailEmail implements Database.Batchable<sObject>, Database.Stateful, schedulable {
   Organization org;
    global Database.QueryLocator start(Database.BatchableContext bc) {
         String q='select id,name from Organization';
        return Database.getQueryLocator(q);
    }

    global void execute(Database.BatchableContext bc, List<SetupAuditTrail> auditList ){

    }

    global void finish(Database.BatchableContext bc){
        List<AuditTrailEmail__c> receiverEmails = new List<AuditTrailEmail__c>();
        receiverEmails = [Select id,SetupOwnerId  from AuditTrailEmail__c];
        EmailTemplate et=[Select id, name from EmailTemplate where Name=:'audit trail'];

        for(AuditTrailEmail__c em :  receiverEmails){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(et.id);
            mail.setTargetObjectId(em.SetupOwnerId);
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
     global void execute(SchedulableContext sche){
    		database.executeBatch(new AuditTrailEmail(), 15);
     }
}
