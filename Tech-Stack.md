# IAM Project Technical Stack (Pluggable)

This POC is designed to be technology-agnostic; the repository currently uses a sample stack, but the following choices are supported in architecture and implementation.

## IAM / Security

- Current POC: Azure AD for IdP and SCIM provisioning
- Alternate options:
  - Okta (IdP + SCIM)
  - SailPoint IdentityIQ (governance + lifecycle)
  - LDAP / Active Directory (on-prem legacy)

## Protocols

- Current POC: SCIM for provisioning
- Supported protocols:
  - OAuth 2.0
  - OpenID Connect
  - SAML 2.0
  - SCIM

## Backend & Automation

- Current POC script path: Bash + Python (`poc/python`) with SDKs
- Optional implementation: Java Spring Boot (API servers, enterprise services), Node.js (webhooks, serverless integrations)

## Cloud & DevOps

- POC: generic, Terraform as IaC
- Target platforms:
  - AWS (S3/Terraform backend, EKS, IAM roles)
  - Docker (OPA, Vault, utility containers)
  - CI/CD (GitHub Actions, Jenkins, GitLab)
  - Linux-based deployment

## Databases

- POC: Snowflake (data warehouse)
- Alternatives:
  - PostgreSQL / MySQL for data stores
  - MongoDB for metadata/identity graph

## Go-live path

1. Pick an IdP and provisioning source
2. Map a data platform and dataset authorization model
3. Configure policy engine (OPA or commercial PDP)
4. Implement secrets storage (Vault, AWS Secrets Manager)
5. Add automation tests (worst-case data access scenarios)
