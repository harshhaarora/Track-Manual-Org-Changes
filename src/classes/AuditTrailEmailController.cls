public class AuditTrailEmailController {
	private final List<SetupAuditTrail> auditList;
    public boolean isData{get;set;}
    public Organization org{get;set;}
    public AuditTrailEmailController(){
        auditList = [SELECT CreatedDate,CreatedBy.Name,Action,Display,Id,Section 
                     FROM SetupAuditTrail 
                     WHERE CreatedDate = YESTERDAY];
         org = [select id,name from Organization];
		if(auditList.size()>0){
            isData = true;
        }
        else{
            isData = false;
        }
    }
    public map<string, SetupAuditTrail> getDailyAudit(){
        map<string, SetupAuditTrail> auditRecords = new map<string, SetupAuditTrail> ();
        
        for(SetupAuditTrail sat : auditList){
            auditRecords.put(String.Valueof(sat.createdDate), sat);
        }
        return auditRecords;
    }

}