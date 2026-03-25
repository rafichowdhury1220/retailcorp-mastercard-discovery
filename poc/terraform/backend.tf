terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# To use remote state, override with backend config arguments on `terraform init`:
# terraform init -backend-config="bucket=<your_bucket>" -backend-config="key=poc/terraform.tfstate" -backend-config="region=us-east-1"
