# IAM Project for RetailCorp Mastercard Discovery

This repository contains a complete IAM engineering project built from the Mastercard data discovery work.

## Goal

Enable secure, auditable, least-privilege access for BankCorp Mastercard data ingestion into RetailCorp EDP.

## Structure

- `IAM-Engineer-Solution-Architecture.md` - solution architecture and capability model
- `IAM-Project-Plan.md` - implementation roadmap and milestones
- `IAM-Definitions.md` - glossary for roles, resources, and policies
- `IAM-Checklist.md` - compliance and validation checklist
- `Tech-Stack.md` - chosen and alternate technology options

## Quick start

1. Review `IAM-Engineer-Solution-Architecture.md`
2. Align on target systems and trust boundaries
3. Run the pilot (phase 1 implementation)
4. Execute cycles from `IAM-Project-Plan.md`

## Run the POC

### Terraform path (Snowflake + Azure AD)

1. Set environment variables:
   - `SNOWFLAKE_ACCOUNT`
   - `SNOWFLAKE_USER`
   - `SNOWFLAKE_PASSWORD`
2. Run:
   - `chmod +x poc/scripts/run_poc.sh`
   - `poc/scripts/run_poc.sh`
3. Validate:
   - `poc/scripts/test_opa_evaluation.sh`
   - Snowflake SQL test: `poc/scripts/test_snowflake_role_permissions.sql`
   - SCIM: `poc/scripts/test_azure_ad_scim_provisioning.sh`

### Python path (Okta + AWS RDS/PostgreSQL)

1. Set environment variables:
   - `OKTA_ORG_URL`
   - `OKTA_API_TOKEN`
   - `POSTGRES_HOST` (from RDS endpoint)
   - `POSTGRES_PASSWORD`
   - `POSTGRES_USER` (optional)
   - `AWS_PROFILE` or `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`
2. Run:
   - `chmod +x poc/python/run_poc_python.sh`
   - `poc/python/run_poc_python.sh`
3. Run database role setup:
   - `python poc/python/setup_postgres_roles.py`
