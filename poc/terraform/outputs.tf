output "snowflake_role_poc_data_eng" {
  value = snowflake_role.poc_data_eng.name
}

output "azuread_group_poc_data_engineers_id" {
  value = azuread_group.poc_data_engineers.id
}
