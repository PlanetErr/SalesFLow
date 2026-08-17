public class LeadTriggerHandler {

    public static void handleBeforeSave(
        List<Lead> leads
    ) {

        for (Lead lead : leads) {

            if (
                String.isNotBlank(lead.Email) &&
                String.isNotBlank(lead.Phone)
            ) {

                lead.Qualified__c = true;

            } else {

                lead.Qualified__c = false;

            }
        }
    }
}