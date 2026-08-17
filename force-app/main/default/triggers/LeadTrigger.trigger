trigger LeadTrigger on Lead (before insert, before update) {

    LeadTriggerHandler.handleBeforeSave(
        Trigger.new
    );

}