#!/usr/bin/env bash
set -e

BASE=$(cd "$(dirname "$0")/.." && pwd)
cd "$BASE/terraform"

echo "Initializing Terraform..."
terraform init

echo "Planning Terraform..."
terraform plan -var="snowflake_account=${SNOWFLAKE_ACCOUNT}" \
  -var="snowflake_user=${SNOWFLAKE_USER}" \
  -var="snowflake_password=${SNOWFLAKE_PASSWORD}" \
  -out=tfplan

echo "Apply Terraform..."
terraform apply -auto-approve tfplan

echo "POC Terraform apply complete."
