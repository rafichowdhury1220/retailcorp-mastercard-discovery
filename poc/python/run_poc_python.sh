#!/usr/bin/env bash
set -e

BASE=$(cd "$(dirname "$0")/.." && pwd)
cd "$BASE/python"

if [ ! -f "requirements.txt" ]; then
  echo "requirements.txt missing"
  exit 1
fi

echo "Installing Python dependencies"
pip install -r requirements.txt

echo "Running setup_infra.py"
python setup_infra.py

echo "Ensure your POSTGRES_HOST from RDS endpoint is set in env and run setup_postgres_roles.py"
