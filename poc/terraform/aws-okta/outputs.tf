output "postgres_endpoint" {
  value = aws_db_instance.iam_poc_db.address
}

output "postgres_db_name" {
  value = aws_db_instance.iam_poc_db.name
}

output "okta_edp_data_engineers_group_id" {
  value = okta_group.edp_data_engineers.id
}

output "okta_edp_analysts_group_id" {
  value = okta_group.edp_analysts.id
}
