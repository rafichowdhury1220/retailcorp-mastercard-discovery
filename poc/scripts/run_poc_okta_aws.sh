#!/usr/bin/env bash
set -e

BASE=$(cd "$(dirname "$0")/.." && pwd)
cd "$BASE/terraform/aws-okta"

echo "Initializing Terraform for Okta+AWS+PostgreSQL POC..."
terraform init

echo "Planning Terraform..."
terraform plan -var="okta_org_name=${OKTA_ORG_NAME}" \
  -var="okta_api_token=${OKTA_API_TOKEN}" \
  -var="postgres_password=${POSTGRES_PASSWORD}" \
  -var="postgres_username=${POSTGRES_USERNAME}"

echo "Applying Terraform..."
terraform apply -auto-approve

echo "Done."
