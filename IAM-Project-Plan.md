# IAM Implementation Roadmap

## Phase 1: Discovery & Design

- [x] Capture existing flow and artifacts (from existing discovery document)
- [x] Define IAM trust zones and critical data assets
- [x] Select IdP and CI/CD integration points
- [ ] Create baseline RBAC/ABAC model
- [ ] Approve architecture with stakeholders

## Phase 2: Proof of Concept

- [ ] Set up IdP integration (Azure AD / Okta)
- [ ] Implement onboarding/offboarding via SCIM
- [ ] Deploy policy engine for ETL and dataset access
- [ ] Enable secrets management for BankCorp feeds
- [ ] Integrate audit logs with SIEM

## Phase 3: Hardening & Governance

- [ ] Deploy access certification processes
- [ ] Add JIT elevation for privileged tasks
- [ ] Establish compliance reporting (PCI, SOC2, GDPR)
- [ ] Do 6-week controls gap assessment

## Phase 4: Production rollout

- [ ] Cut over to production IAM policies and workflows
- [ ] Run internal training for Data & Marketing users
- [ ] Operational runbook for incident, revoke, rotation
- [ ] Post-mortem and optimization cycle

## Next steps (detailed)

1. Complete baseline design items
   - [ ] Finalize RBAC and ABAC role matrix with data owners
   - [ ] Confirm scope of sensitive assets and least-privilege mapping
   - [ ] Document trust boundaries and attacker model

2. Build baseline PoC infrastructure
   - [ ] Add `poc/terraform/variables.tf`, `outputs.tf`, and backend config
   - [ ] Create a `poc/terraform/env` profile for dev/test/prod
   - [ ] Create sample SCIM user/group provisioning script and test vectors

3. Harden POC security and governance
   - [ ] Apply static analysis (Checkov/Terrascan) to Terraform
   - [ ] Create `IAM-Checklist.md` gating for each compliance control
   - [ ] Publish access review playbook + operational runbook

4. Execute validation cycles
   - [ ] Deploy into sandbox and run exfiltration/segmentation tests
   - [ ] Collect audit log examples and verify SIEM pipeline
   - [ ] Complete control evidence folders for PCI/SOC2/GDPR

5. Formalize rollout & handoff
   - [ ] Create runbook for production token rotation and emergency revoke
   - [ ] Schedule formal signoff with Security, Legal, and Business sponsors
   - [ ] Document retrospectives and improvement backlog
