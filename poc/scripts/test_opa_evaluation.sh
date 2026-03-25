#!/usr/bin/env bash

# Example OPA evaluation for POC
cat <<EOF > /tmp/poc_input.json
{
  "user": { "role": "POC_DATA_ENG" },
  "resource": { "db": "MCST", "schema": "landing" },
  "action": "write"
}
EOF

opa eval --data ../opa/poc_policy.rego --input /tmp/poc_input.json "data.iam_poc.allow"
