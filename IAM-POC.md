# IAM POC for RetailCorp Mastercard Discovery

This document describes a proof-of-concept implementation for IAM controls and automation, anchored in the previously created architecture and plan.

## Objective

- Validate federated identity + provisioning
- Enforce least privilege on a sample data ingestion path
- Capture audit logging and access review artifacts

## Scope

- Identity provider: Azure AD
- Data platform: Snowflake (as EDP representative)
- Policy engine: OPA with Kubernetes sidecar for data access control
- Secrets store: HashiCorp Vault

## POC components

### 1) Azure AD SSO + SCIM provisioning

- Register an application in Azure AD
- Enable `user.read` and `Group.Read.All` permissions
- Enable SCIM provisioning to a target group `EDP-DataEngineers`

### 2) Snowflake RBAC sandbox

- Create roles: `POC_DATA_ENG`, `POC_ANALYST`
- Grant minimal privileges:
  - `POC_DATA_ENG`: CREATE WAREHOUSE, USAGE on DATABASE `MCST`, SELECT/INSERT on SCHEMA `landing`
  - `POC_ANALYST`: USAGE on DATABASE `MCST`, SELECT on SCHEMA `curated`

### 3) OPA policy for dataset access

- Enforce ABAC through attributes:
  - `role` from SCIM groups
  - `environment` (dev/test/prod)
  - `sensitivity` (PII, non-PII)

### 4) Vault secret for BankCorp feed consumer

- Create path: `secret/data/bankcorp/feed-client`
- Manage key rotation via script

## Deliverables

- This POC file (`IAM-POC.md`)
- Terraform scripts under `poc/terraform`
- Example OPA policy in `poc/opa`

## Validation tests

- `test_azure_ad_scim_provisioning.sh` (in/out user to group)
- `test_snowflake_role_permissions.sql` (access checks)
- `test_opa_evaluations.policy` (ABAC rules)
