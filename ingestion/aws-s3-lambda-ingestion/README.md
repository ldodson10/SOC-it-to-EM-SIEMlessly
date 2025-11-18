# gvrdc-aws-infra
Terraform code for the Global Viral Research Defense Center (GVRDC) Capstone Project. Manages the AWS multi-account security architecture 

## Sprint 2 Deliverables

### 🧩 Sprint 2 – Deliverable 4: Logging Module (S3 + Firehose + OpenSearch)

**Objective:**  
Configure centralized logging infrastructure using Terraform to integrate S3 archival, Kinesis Firehose delivery, and OpenSearch analytics.

**Components Implemented:**
- S3 Archive Bucket with lifecycle and compression policy  
- Kinesis Firehose delivery stream for real-time ingestion  
- Integration with OpenSearch (endpoint pending)  
- IAM role configuration for Firehose and Lambda  

**Evidence:**
- `LocalOS_LoggingModule_Validation_Success.png`  
- `Terraform_Firehose_AccessDenied.png`  
- `Sprint2_Deliverable4_TrelloUpdate.png`  

**Status:** Completed (awaiting OpenSearch ingestion test)  
**Owner:** Latrisha Dodson (Data Quarantine Architect)
Forcing a new deployment run with all fixes..
