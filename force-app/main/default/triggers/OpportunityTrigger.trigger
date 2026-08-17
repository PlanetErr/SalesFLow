trigger OpportunityTrigger on Opportunity (
    before insert,
    before update,
    after update
) {

    if (Trigger.isBefore) {

        OpportunityTriggerHandler.handleBeforeSave(
            Trigger.new
        );

    }

    if (Trigger.isAfter && Trigger.isUpdate) {

        OpportunityTriggerHandler.handleAfterUpdate(
            Trigger.new,
            Trigger.oldMap
        );

    }

}