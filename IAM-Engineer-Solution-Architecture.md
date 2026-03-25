# IAM Engineer Solution Architecture

This project file is derived from the existing `RetailCorp Mastercard Discovery Project` and is reframed to capture a complete Identity and Access Management (IAM) engineering capability stack.

## 1. Project purpose

- Build an enterprise-grade IAM solution for RetailCorp’s Mastercard data ingestion ecosystem.
- Ensure secure data access, least privilege, traceability, and regulatory compliance across the data pipeline.
- Enable internal DMZ, admin, and analytics teams to manage identities, roles, and permissions for EDP, CDP, Marketing tools, and BankCorp external feeds.

## 2. Target systems and touchpoints

- Inbound data feed: BankCorp enrollment/transactions/reconciliation
- Enterprise Data Platform (EDP) and EDW
- CDP, Marketing analytics, and campaign activation systems
- Data Engineering & DevOps pipeline (ETL/ELT, scheduler, archive)
- Identity providers (IdP), MFA, and IAM platform

## 3. Key IAM capabilities

1. Identity lifecycle
   - Source identity federation (SAML, OIDC) from corporate Active Directory/Azure AD
   - Provisioning (SCIM) for data engineering, analytics, security, and 3rd-party contractors
   - Deprovision when role changes, employment separation, or contractor offboarding

2. Authentication
   - Single sign-on (SSO) to analytics consoles, EDP dashboards, and ingestion tools
   - Multi-factor authentication (MFA) for sensitive admin and DBA roles
   - Passwordless support (FIDO2) for privileged users

3. Authorization
   - Role-based access control (RBAC) for dataset and ETL pipeline operations
   - Attribute-based access control (ABAC) for environment, data classification, and source system context
   - Just-in-time access (JIT) and session approval for elevated tasks (e.g., data movement, edit ingestion logic)

4. Access governance
   - Access certification campaigns for Marketing, Engineering, and Security teams
   - Policy drift detection and sea-based entitlement reconciliation
   - Access request workflow integrated with ITSM (ServiceNow, Jira)

5. Data protection and compliance
   - Fine-grained object-level controls on PII fields (enrollment/transaction IDs, account status)
   - Data masking/redaction in staging and analytics zones
   - Audit logging with SIEM integration (Splunk, Sentinel)

6. Secrets management
   - Centralized vault for credentials, API keys, and connection strings (HashiCorp Vault, AWS Secrets Manager)
   - Rotation and ephemeral credentials for jobs that handle BankCorp feeds

## 4. Architecture overview

```text
[BankCorp SFTP/API] -> [Inbound Landing Zone] -> [Decrypt/Validate/Transform]
                              |
          ----> [IAM PEP/Policy Engine (OPA, Axiomatics)]
                              |
          ----> [EDP/EDW Staging] -> [EDP/EDW Curated] -> [CDP / Reporting]
                              |
                     [Data Catalog + RBAC (Alation, Collibra + Ranger)]

[IdP (Azure AD)] -> [IAM Directory] -> [SSO/MFA] -> [Users + Service Accounts]

[SIEM] <--- [Audit Logs] <--- [All components + IAM platform]
```

## 5. Example functional flows

- New onboarding of a data engineer
  - HR event triggers scaffold in IAM (SCIM)
  - Role assignment: `data-engineer` with read/write staging, read curated
  - SSO access to Snowflake, Kafka UI, Grafana

- BankCorp feed access control
  - Service account for feed consumer enforced by policy engine
  - Least-privilege fine-grained rights on ingestion buckets/tables
  - All access audited with data access context

- Emergency “break glass” access
  - Time-limited privilege escalation via approval workflow
  - Automatic rollback and mandatory post-incident review

## 6. Deliverables

- Architecture diagram + narrative (this file)
- IAM policy catalog for roles/entitlements
- Implementation plan (phased: discovery, PoC, hardening, compliance)
- Validation checklist (security, privacy, SLA, audit)

## 7. Next steps for the team

1. Validate existing artifact data flows from the original discovery file
2. Identify all IAM trust boundaries and sensitive assets in the EDP pipeline
3. Build a pilot with an IdP, vault secrets management, and policy enforcement on one dataset
4. Include governance workflow for access requests and periodic reviews

---

> Notes: This document is a starting point for an IAM engineer ready to convert discovery insights into secure, compliance-ready production architecture.
