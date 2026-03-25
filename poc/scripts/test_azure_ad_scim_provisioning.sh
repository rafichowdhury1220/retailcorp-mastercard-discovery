#!/usr/bin/env bash
set -e

# Placeholder: run this after deploying an Azure AD Enterprise App with SCIM mapping.
# Requires AZURE_ACCESS_TOKEN available and SCIM endpoint configured.

if [ -z "$SCIM_BASE_URL" ] || [ -z "$AZURE_ACCESS_TOKEN" ]; then
  echo "Set SCIM_BASE_URL and AZURE_ACCESS_TOKEN"
  exit 1
fi

curl -X GET "$SCIM_BASE_URL/Users" \
  -H "Authorization: Bearer $AZURE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" | jq '.'

echo "SCIM provisioning endpoint reachable."
