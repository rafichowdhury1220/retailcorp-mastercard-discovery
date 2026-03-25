variable "snowflake_account" {
  description = "Snowflake account identifier"
  type        = string
}

variable "snowflake_user" {
  description = "Snowflake admin username"
  type        = string
}

variable "snowflake_password" {
  description = "Snowflake admin password"
  type        = string
  sensitive   = true
}

variable "terraform_state_bucket" {
  description = "S3 bucket for Terraform state. Optional in local mode"
  type        = string
  default     = ""
}

variable "region" {
  description = "Cloud region for optional provider state"
  type        = string
  default     = "us-east-1"
}
