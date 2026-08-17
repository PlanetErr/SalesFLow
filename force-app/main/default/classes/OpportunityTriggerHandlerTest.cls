@IsTest
private class OpportunityTriggerHandlerTest {

    @IsTest
    static void testFollowUpTaskCreated() {

        // Create an Opportunity in the stage before negotiation
        Opportunity opp = new Opportunity(
            Name = 'SalesFlow Test Opportunity',
            StageName = 'Proposal/Price Quote',
            CloseDate = Date.today().addDays(30)
        );

        insert opp;

        // Change the stage to Negotiation/Review
        Test.startTest();

        opp.StageName = 'Negotiation/Review';
        update opp;

        Test.stopTest();

        // Find Tasks related to our Opportunity
        List<Task> tasks = [
            SELECT Id, Subject, WhatId, OwnerId, ActivityDate
            FROM Task
            WHERE WhatId = :opp.Id
        ];

        // Verify that exactly one Task was created
        System.assertEquals(
            1,
            tasks.size(),
            'A follow-up Task should have been created.'
        );

        // Verify the Task details
        System.assertEquals(
            'Follow up on Opportunity',
            tasks[0].Subject
        );

        System.assertEquals(
            opp.Id,
            tasks[0].WhatId
        );
    }
    @IsTest
static void testAtRiskOpportunity() {

    Opportunity opp = new Opportunity(
        Name = 'At Risk Test Opportunity',
        StageName = 'Proposal/Price Quote',
        CloseDate = Date.today().addDays(3)
    );

    Test.startTest();

    insert opp;

    Test.stopTest();

    Opportunity savedOpp = [
        SELECT Id, At_Risk__c
        FROM Opportunity
        WHERE Id = :opp.Id
    ];

    System.assertEquals(
        true,
        savedOpp.At_Risk__c,
        'Opportunity closing within 7 days should be marked as At Risk.'
    );
}
}