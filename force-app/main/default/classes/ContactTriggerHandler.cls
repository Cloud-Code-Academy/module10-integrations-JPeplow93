public with sharing class ContactTriggerHandler extends TriggerHandler {
    
    private List<Contact> updatedContList;
    private List<Contact> oldContList;
    
    public ContactTriggerHandler() {
        this.updatedContList = (List<Contact>) Trigger.new;
        this.oldContList = (List<Contact>) Trigger.old;
    }

    public override void beforeInsert(){
        // When a contact is inserted
        for(Contact c : updatedContList){
        // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
            if(c.DummyJSON_Id__c == null){
                c.DummyJSON_Id__c = String.valueOf(Math.round(Math.random() * 100));
            } 
        // if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
        if(Integer.valueOf(c.DummyJSON_Id__c) <= 100){
            callGetDummyJSONUserFromId(c.DummyJSON_Id__c);
        }
    }
}

        @future (callout = true)
        private static void callGetDummyJSONUserFromId(String contactId) {
        DummyJSONCallout.getDummyJSONUserFromId(contactId);
            }
	
    public override void beforeUpdate(){
	//When a contact is updated
    for(Contact c : updatedContList){
	// if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
    if(Integer.valueOf(c.DummyJSON_Id__c) > 100){
        DummyJSONCallout.postCreateDummyJSONUser(c.Id);
    }
    }
    }
}