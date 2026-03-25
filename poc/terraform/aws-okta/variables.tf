variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "okta_org_name" {
  description = "Okta organization name"
  type        = string
}

variable "okta_api_token" {
  description = "Okta API token"
  type        = string
  sensitive   = true
}

variable "postgres_username" {
  description = "PostgreSQL master username"
  type        = string
  default     = "admin"
}

variable "postgres_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "iam_poc"
}
