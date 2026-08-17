public class OpportunityTriggerHandler {

    public static void handleBeforeSave(
        List<Opportunity> opportunities
    ) {

        Date today = Date.today();
        Date riskDate = today.addDays(7);

        for (Opportunity opp : opportunities) {

            if (
                opp.IsClosed == false &&
                opp.CloseDate <= riskDate &&
                opp.CloseDate >= today
            ) {

                opp.At_Risk__c = true;

            } else {

                opp.At_Risk__c = false;

            }
        }
    }


    public static void handleAfterUpdate(
        List<Opportunity> newOpportunities,
        Map<Id, Opportunity> oldOpportunityMap
    ) {

        Set<Id> opportunityIds = new Set<Id>();

        for (Opportunity opp : newOpportunities) {

            Opportunity oldOpp = oldOpportunityMap.get(opp.Id);

            if (
                opp.StageName == 'Negotiation/Review' &&
                oldOpp.StageName != 'Negotiation/Review'
            ) {

                opportunityIds.add(opp.Id);
            }
        }

        if (opportunityIds.isEmpty()) {
            return;
        }

        List<Opportunity> opportunities = [
            SELECT Id, Name, OwnerId
            FROM Opportunity
            WHERE Id IN :opportunityIds
        ];

        List<Task> tasksToCreate = new List<Task>();

        for (Opportunity opp : opportunities) {

            Task followUpTask = new Task();

            followUpTask.Subject = 'Follow up on Opportunity';
            followUpTask.WhatId = opp.Id;
            followUpTask.OwnerId = opp.OwnerId;
            followUpTask.ActivityDate = Date.today().addDays(2);

            tasksToCreate.add(followUpTask);
        }

        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }
    }
}