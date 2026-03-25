terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    okta = {
      source  = "okta/okta"
      version = "~> 3.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.16"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "okta" {
  org_name  = var.okta_org_name
  api_token = var.okta_api_token
}

provider "postgresql" {
  host            = aws_db_instance.iam_poc_db.address
  port            = aws_db_instance.iam_poc_db.port
  database        = aws_db_instance.iam_poc_db.name
  username        = aws_db_instance.iam_poc_db.username
  password        = aws_db_instance.iam_poc_db.password
  sslmode         = "require"
}
