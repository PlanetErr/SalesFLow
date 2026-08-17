# 🚀 SalesFlow — Salesforce Sales Automation

SalesFlow is a beginner-friendly Salesforce project built using **Apex, Triggers, SOQL, DML, Apex Tests, Reports, and Dashboards**.

The goal is to automate common sales activities and help sales teams identify opportunities that need attention.

## ✨ Features

1. Automatic Opportunity Follow-Up
When an Opportunity moves to **Negotiation/Review**, Salesforce automatically creates a follow-up Task for the Opportunity owner.

 2. At-Risk Opportunity Detection
Open Opportunities with a Close Date within the next **7 days** are automatically marked as **At Risk**.

3. Lead Qualification
A Lead is automatically marked as **Qualified** when both **Email** and **Phone** are available.

4. Sales Dashboard
A Salesforce dashboard provides:

- Open Pipeline
- At-Risk Opportunities
- Qualified Leads
- Pipeline by Stage

  Architecture


Salesforce Record
       ↓
     Trigger
       ↓
  Apex Handler
       ↓
 Business Logic
       ↓
Updated Salesforce Data
       ↓
Reports & Dashboard

*Project Structure
salesflow/
│
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/
│           │   ├── LeadTriggerHandler.cls
│           │   ├── LeadTriggerHandlerTest.cls
│           │   ├── OpportunityTriggerHandler.cls
│           │   └── OpportunityTriggerHandlerTest.cls
│           │
│           └── triggers/
│               ├── LeadTrigger.trigger
│               └── OpportunityTrigger.trigger
│
├── sfdx-project.json
├── .gitignore
└── README.md
