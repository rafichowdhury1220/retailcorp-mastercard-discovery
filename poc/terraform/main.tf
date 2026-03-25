terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.45"
    }
  }
}

provider "azuread" {
}

provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_user
  password = var.snowflake_password
  role     = "ACCOUNTADMIN"
}

# Example group + role mapping
resource "azuread_group" "poc_data_engineers" {
  display_name = "EDP-DataEngineers"
  security_enabled = true
}

resource "snowflake_role" "poc_data_eng" {
  name = "POC_DATA_ENG"
  comment = "Sandbox role for POC data engineers"
}

resource "snowflake_role_grants" "poc_data_eng_grants" {
  role_name = snowflake_role.poc_data_eng.name
  privileges = ["USAGE"]
  on_future = "schema"
  on_object = "database"
  database_name = "MCST"
}
