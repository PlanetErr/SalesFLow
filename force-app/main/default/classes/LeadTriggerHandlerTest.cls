@IsTest
private class LeadTriggerHandlerTest {

    @IsTest
    static void testQualifiedLead() {

        Lead lead = new Lead(
            LastName = 'Qualified Test',
            Company = 'SalesFlow',
            Email = 'test@example.com',
            Phone = '9876543210'
        );

        Test.startTest();

        insert lead;

        Test.stopTest();

        Lead savedLead = [
            SELECT Id, Qualified__c
            FROM Lead
            WHERE Id = :lead.Id
        ];

        System.assertEquals(
            true,
            savedLead.Qualified__c,
            'Lead with Email and Phone should be Qualified.'
        );
    }


    @IsTest
    static void testUnqualifiedLead() {

        Lead lead = new Lead(
            LastName = 'Unqualified Test',
            Company = 'SalesFlow',
            Email = 'test@example.com'
        );

        Test.startTest();

        insert lead;

        Test.stopTest();

        Lead savedLead = [
            SELECT Id, Qualified__c
            FROM Lead
            WHERE Id = :lead.Id
        ];

        System.assertEquals(
            false,
            savedLead.Qualified__c,
            'Lead without Phone should not be Qualified.'
        );
    }
}