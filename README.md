# SOC it to ’EM SIEMlessly

*A Multi-Account Cloud Governance, Logging, and Threat Detection Architecture on AWS*

---

## 📌 Project Summary

SOC it to ’EM SIEMlessly is a cloud-native, multi-account SIEM and governance architecture that centralizes audit logging, threat detection, and compliance enforcement across AWS environments.

The system integrates:

- AWS Organizations (intended multi-account design)
- Security Hub, GuardDuty, Inspector (delegated admin model)
- CloudTrail (multi-region)
- VPC Flow Logs
- S3 Log Archive with versioning and encryption
- Glue Data Catalog + Athena
- EventBridge → Lambda → OpenSearch pipeline
- Terraform IaC modules (logging, SIEM, ingestion, VPC)
- Restricted-role AWS SSO access for separation of duties

This README distinguishes:

1. Intended enterprise architecture  
2. Components manually validated during Sprint 4 under the SIEM-Data-Architect read-only role  

---

## 1. Architecture Overview

The validated AWS SIEM/governance architecture unifies:

- CloudTrail log delivery  
- VPC Flow Logs → S3  
- Glue + Athena schema and query layer  
- Security Hub, GuardDuty, Inspector  
- EventBridge → Lambda ETL path  
- OpenSearch dashboards  
- Delegated administrator governance model  
- Multi-account structure (Management → Log Archive → Security Tooling → Member Accounts)

---

## 2. Intended Multi-Account Governance Architecture

Although the restricted SSO role prevented provisioning, the capstone includes a complete enterprise design.

### 2.1 Organizational Structure

- Management Account  
- Log Archive Account  
- Security Tooling Account  
- Multiple Member Accounts  

### 2.2 Delegated Administrator Assignments

- Security Hub  
- GuardDuty  
- Inspector  

### 2.3 Cross-Account Log Aggregation

| Source           | Log Type          | Destination   | Mechanism                            |
|------------------|-------------------|---------------|--------------------------------------|
| Member Accounts  | CloudTrail        | Log Archive   | S3 log bucket                        |
| Member Accounts  | VPC Flow Logs     | Log Archive   | VPC Flow Logs                        |
| Member Accounts  | Security Findings | Security Tooling | EventBridge + Delegated Admin   |

### 2.4 Query & Analytics Layer

- Glue defines schema  
- Athena queries S3  
- Lambda → OpenSearch indexes findings  

---

## 3. Manually Validated Components (Sprint 4)

Executed under the **SIEM-Data-Architect (Read-Only)** SSO role.

### 3.1 CloudTrail (Multi-Region)

- Validated event history  
- Confirmed account-level governance  
- Verified permission boundaries preventing trail creation  

**Evidence**  
`./sprint4/evidence/s4_cloudtrail_view_only.png`

### 3.2 S3 Central Log Archive

Bucket: `gvrdc-central-logs-ld-us-east-1`

- Versioning enabled  
- SSE encryption verified  
- CloudTrail and Flow Logs delivery confirmed  

**Evidence**  
`./sprint4/evidence/s4_s3_log_archive_bucket.png`

### 3.3 VPC Flow Logs → S3 Delivery

- Located FlowLogs folder and log files  
- Verified log record structure  

**Evidence**  
`./sprint4/evidence/s4_flowlogs_s3_delivery.png`

### 3.4 Athena (Read-Only Validation)

- Verified workgroups and query history  
- Captured permission boundaries for DDL operations  

**Evidence**  
`./sprint4/evidence/s4_athena_read_only.png`

### 3.5 Security Hub / GuardDuty / Inspector – View-Only

- Confirmed findings display  
- Confirmed modification limitations  

**Evidence**  
`./sprint4/evidence/s4_security_services_view_only.png`

### 3.6 Glue – Access Denied (Expected)

- Validated that Glue database creation is blocked by role policy  

**Evidence**  
`./sprint4/evidence/s4_glue_access_denied.png`

### 3.7 Final System Architecture Diagram

**Evidence**  
`./sprint4/Architecture_Diagram.png`

---

## 4. Sprint Documentation (Sprints 1–4)

### 4.1 Sprint 1 — Foundations

**Completed**

- Repository setup  
- Initial SIEM architecture scoping  
- AWS SSO login  
- IAM role boundary identification  

**Evidence**

| Description                          | File                                                              |
|--------------------------------------|-------------------------------------------------------------------|
| Permission denied – Security Services | `./sprint1/evidence/s1_permission_denied_security_services.png`  |
| CloudTrail create denied             | `./sprint1/evidence/s1_cloudtrail_create_denied.png`             |
| General permission boundary          | `./sprint1/evidence/s1_permission_boundary_general.png`          |
| AWS Console access                   | `./sprint1/evidence/s1_aws_console_access.png`                   |
| Architecture planning                | `./sprint1/evidence/s1_architecture_planning.png`                |

---

### 4.2 Sprint 2 — Logging Module (Terraform)

**Completed**

- S3 archival bucket architecture  
- Firehose ingestion planning  
- Terraform initialization and validation  
- Logging module directory verification  

**Evidence**

| Description                       | File                                                       |
|-----------------------------------|------------------------------------------------------------|
| AWS STS identity verification     | `./sprint2/evidence/s2_aws_sts_identity.png`              |
| Terraform init                    | `./sprint2/evidence/s2_terraform_init.png`                |
| Terraform plan / output           | `./sprint2/evidence/s2_terraform_plan_output.png`         |
| Logging S3 bucket                 | `./sprint2/evidence/s2_s3_logging_bucket.png`             |
| Logging module directory          | `./sprint2/evidence/s2_logging_module_directory.png`      |
| Logging pipeline design           | `./sprint2/evidence/s2_logging_pipeline_design.png`       |

---

### 4.3 Sprint 3 — VPC Architecture & AWS CLI Validation

**Completed**

- VPC creation  
- Subnets (public and private)  
- Route tables  
- NAT Gateway  
- NACLs  
- Security groups  

**Evidence**

| Description          | File                                                  |
|----------------------|-------------------------------------------------------|
| VPC dashboard        | `./sprint3/evidence/s3_vpc_dashboard.png`            |
| Subnets view         | `./sprint3/evidence/s3_subnets_view.png`             |
| Route tables         | `./sprint3/evidence/s3_route_tables.png`             |
| IGW and NAT Gateway  | `./sprint3/evidence/s3_internet_nat_gateway.png`     |
| NACL configuration   | `./sprint3/evidence/s3_nacls.png`                    |
| Security groups      | `./sprint3/evidence/s3_security_groups.png`          |

---

### 4.4 Sprint 4 — Governance Components (Manual Provisioning)

*(Performed under restricted SSO role)*

**Completed**

- CloudTrail validation  
- S3 Log Archive verification  
- Flow Log parsing  
- Athena read-only validation  
- Security services read-only validation  
- Glue access-denied confirmation  
- Final architecture diagram generation  

**Evidence**

| Description                | File                                                       |
|----------------------------|------------------------------------------------------------|
| CloudTrail view-only       | `./sprint4/evidence/s4_cloudtrail_view_only.png`          |
| Central log archive bucket | `./sprint4/evidence/s4_s3_log_archive_bucket.png`         |
| Flow Logs → S3             | `./sprint4/evidence/s4_flowlogs_s3_delivery.png`          |
| Athena read-only           | `./sprint4/evidence/s4_athena_read_only.png`              |
| Security services view-only| `./sprint4/evidence/s4_security_services_view_only.png`   |
| Glue access denied         | `./sprint4/evidence/s4_glue_access_denied.png`            |
| Architecture diagram       | `./sprint4/Architecture_Diagram.png`                      |

---

## 5. Repository Structure

```text
SOC-it-to-EM-SIEMlessly/
├── sprint1/
│   └── evidence/
├── sprint2/
│   └── evidence/
├── sprint3/
│   └── evidence/
├── sprint4/
│   ├── Architecture_Diagram.png
│   └── evidence/
├── iac/
├── ingestion/
├── vpc/
├── automation/
├── docs/
├── README.md
└── README_evidence.md

6. Restricted SSO Role — Capabilities vs. Limitations

6.1 Capabilities
*View CloudTrail logs
*View VPC Flow Logs
*Query Athena (read-only)
*View Security Hub, GuardDuty, Inspector
*Access S3 Log Archive

6.2 Limitations
*Cannot create CloudTrail
*Cannot create Glue databases or tables
*Cannot create DynamoDB
*Cannot modify Security services
*Cannot run Athena DDL
*Cannot deploy CloudFormation

7. Future Enhancements
*Automated delegated admin provisioning
*Glue ETL normalization workflows
*Security Hub → Lambda → OpenSearch ingestion
*Automated remediation using EventBridge
*Multi-account SIEM ingestion pipeline
*Managed “SIEM-as-a-Service” model for SMBs