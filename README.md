SOC it to ’EM SIEMlessly
A Multi-Account Cloud Governance, Logging, and Threat Detection Architecture on AWS
📌 Project Summary

SOC it to ’EM SIEMlessly is a cloud-native multi-account security governance architecture designed to centralize audit logging, threat detection, and compliance workflows across an enterprise AWS environment.

The system integrates:

AWS Organizations (intended multi-account governance model)

Security Hub, GuardDuty, Inspector (delegated admin pattern)

CloudTrail (multi-region, multi-account logging)

VPC Flow Logs (centralized)

S3 Log Archive (versioning + encryption)

Glue Data Catalog + Athena (query layer)

EventBridge → Lambda → OpenSearch (indexing + dashboards)

Terraform IaC modules (modular, reusable)

Restricted AWS SSO role boundaries for separation of duties

This README distinguishes:

The intended enterprise multi-account SIEM/governance architecture

The manually provisioned Sprint 4 components, completed under the restricted SIEM-Data-Architect role.

1. Architecture Overview

Below is the final validated AWS architecture for the SIEM/governance pipeline:
![Architecture Diagram](./sprint4/Architecture_Diagram.png)

This system unifies:

CloudTrail log delivery

VPC Flow Logs

S3 central logging

Glue schema + Athena query layer

GuardDuty, Inspector, Security Hub findings

EventBridge → Lambda ETL

OpenSearch dashboards

CloudFormation provisioning

Multi-account delegated administration

2. Intended Multi-Account Governance Architecture

Even though role restrictions prevented provisioning, the project includes a full enterprise governance design.

Organizational Structure

Management Account

Log Archive Account

Security Tooling Account

Workload Member Accounts

Delegated Administrator Assignments

Security Hub Delegated Admin

GuardDuty Delegated Admin

Inspector Delegated Admin

Cross-Account Log Aggregation
Source Account	Log Type	Destination Account	Mechanism
Member Accounts	CloudTrail	Log Archive	S3 Log Bucket
Member Accounts	VPC Flow Logs	Log Archive	VPC Flow Log Delivery
Member Accounts	Security Findings	Security Tooling	Delegated Admin + EventBridge
Query & Analytics Pipeline

Glue catalog defines schemas

Athena queries the S3 log archive

EventBridge + Lambda forwards findings to OpenSearch

3. Manually Provisioned Components (Sprint 4)

Provisioned using the SIEM-Data-Architect SSO role (read-only restrictions in Glue/Athena).

✔ CloudTrail (Multi-Region Trail Enabled)

✔ S3 Central Log Archive (Versioning + Encryption Enabled)

✔ VPC Flow Logs → S3 Delivery

✔ Athena — Restricted Read-Only Access

✔ Flow Log File Parsing Validation

✔ Final System Architecture Diagram (Confirmed)

📁 Full Sprint 4 Evidence Folder:

/sprint4/evidence/

4. Sprint Documentation (Sprints 1–4)
Sprint 1 — Foundations
Completed

Repository initialization

Project folder structure creation

Core README.md draft

Initial documentation layout

AWS SSO login (if applicable)

Local Git environment configured

Successful Git commit and push verification

📸 Sprint 1 Evidence
1. GitHub Repository Structure Rendered Successfully

This confirms the repository root, folders, and README render correctly in GitHub.

./sprint1/evidence/GitHub_RepoStructure_Rendered_Success.png


2. Successful Local Git Push

Validates the local development environment, Git CLI, SSO token (if applicable), and branch sync pipeline.

./sprint1/evidence/LocalOS_GitPush_Success_SIEMlessly.png


3. README Structure Verified in VS Code

This screenshot confirms that the README.md scaffolding was created and rendered properly during Sprint 1.

./sprint1/evidence/README_Structure_CodeBlock.png


4. README Verification Section Completed

Demonstrates the successful completion of the initial documentation block.

./sprint1/evidence/README_Verification_Section_Complete.png

📁 Sprint 1 Evidence Folder

All Sprint 1 screenshots are stored in:

/sprint1/evidence/

Sprint 2 — Logging Module (Terraform)
Completed

S3 archival bucket created

Terraform modules initialized and validated

Logging module generated and reviewed

Firehose → OpenSearch architecture drafted (IAM constraints documented)

VPC deployment revalidated as a prerequisite for log delivery

📸 Sprint 2 Evidence (Condensed to 3 Files)
1. Logging Module README — Generated Configuration

Represents successful Terraform module generation and setup.

./sprint2/evidence/LocalOS_LoggingModule_README_Generated_Config.png


2. Logging Module Validation — Success

Demonstrates correct Terraform wiring and module validation.

./sprint2/evidence/LocalOS_LoggingModule_Validation_Success.png


3. Terraform Init + Validate — Successful Deployment

Represents Terraform initialization and validation for the logging pipeline.

./sprint2/evidence/Terraform_Validate_Success.png


📁 Sprint 2 Evidence Folder

All Sprint 2 screenshots (full set) are archived in:

/sprint2/evidence/

Sprint 3 — VPC Architecture & AWS CLI Validation
Completed

VPC (10.0.0.0/16) created and verified

Public and private subnets deployed

Region, routing, and NACLs confirmed

AWS SSO session and IAM role validated

Terraform state compared and confirmed without duplicates

📸 Sprint 3 Evidence (Condensed to 3 Files)
1. VPC Creation & Region Verification
./sprint3/evidence/VPC_Region_Confirmation.png


2. Subnets Created Successfully
./sprint3/evidence/Subnets_us-east-1a_1b.png


3. AWS CLI SSO Session Verified
./sprint3/evidence/CLI_SSO_Session_Confirmed.png


📁 Sprint 3 Evidence Folder

All Sprint 3 screenshots (full set) are archived in:

/sprint3/evidence/


Sprint 4 — Governance Components (Manual Provisioning)

This sprint required manually configuring governance + logging components using the restricted SIEM-Data-Architect SSO role.

Evidence (All Embedded Above)

CloudTrail (multi-region)

VPC Flow Logs delivery

S3 Log Archive

Athena read-only validation

Flow Log file parsing

Final architecture diagram

Sprint 4 — Governance Components (Manual Provisioning)
Completed

Enabled CloudTrail Multi-Region Trail

Configured S3 Central Log Archive with versioning + SSE

Enabled VPC Flow Logs → S3 delivery

Verified Athena read-only role constraints

Confirmed Flow Log file integrity

Produced Final Architecture Diagram

All configurations were performed under the restricted SIEM-Data-Architect AWS SSO role.

📸 Sprint 4 Evidence (Condensed to 3 Files)
1. CloudTrail Multi-Region Trail Enabled
./sprint4/evidence/CloudTrail_CreateTrail.png


2. S3 Central Log Bucket — Versioning & Encryption Enabled
./sprint4/evidence/S3_LogBucket_Encryption_Enabled.png


3. VPC Flow Logs Delivered to S3
./sprint4/evidence/VPCFlowLogs_Active.png


📁 Sprint 4 Evidence Folder

The complete Sprint 4 screenshot collection is stored in:

/sprint4/evidence/


5. Repository Structure
SOC-it-to-EM-SIEMlessly/
├── assets/
│   └── Sprint2_Deliverables/
├── automation/
├── config/
├── diagrams/
├── docs/
│   ├── SIEM_VPC_Details.json
│   ├── evidence/
│   │   └── VPC_Setup_Group/
├── ingestion/
├── sprint4/
│   ├── Architecture_Diagram.png
│   ├── evidence/
│   ├── Sprint4_Evidence.md
│   ├── Sprint4_Notes.md
├── iac/
├── vpc/
├── README.md
└── README_evidence.md

6. Restricted SSO Role — Capabilities vs. Limitations
Capabilities

View CloudTrail logs

View VPC Flow Logs

Query Athena (read-only)

View Security Hub, GuardDuty, Inspector

Access S3 log archive

Limitations

Cannot create CloudTrail

Cannot create Glue tables

Cannot create DynamoDB

Cannot run Athena DDL

Cannot deploy CloudFormation

Cannot modify Security Hub / GuardDuty / Inspector

This distinction is required for Sprint 4.

7. Future Enhancements

Automated delegated admin provisioning

Glue ETL normalization for VPC Flow Logs

Security Hub → Lambda → OpenSearch export

Event-driven remediation workflows

Multi-account ingestion pipelines

Managed “SIEM-as-a-Service” model for SMB clientsS