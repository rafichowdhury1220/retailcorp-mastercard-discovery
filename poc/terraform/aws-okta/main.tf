resource "aws_db_subnet_group" "iam_poc" {
  name       = "iam-poc-db-subnet-group"
  subnet_ids = [/* insert subnet IDs */]

  tags = {
    Name = "iam-poc-db-subnet-group"
  }
}

resource "aws_db_instance" "iam_poc_db" {
  identifier         = "iam-poc-db"
  engine             = "postgres"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  name               = var.db_name
  username           = var.postgres_username
  password           = var.postgres_password
  db_subnet_group_name = aws_db_subnet_group.iam_poc.name
  skip_final_snapshot = true
  publicly_accessible = false
  vpc_security_group_ids = []
}

resource "okta_group" "edp_data_engineers" {
  name        = "EDP-DataEngineers"
  description = "Data engineer group for EDP IAM POC"
}

resource "okta_group" "edp_analysts" {
  name        = "EDP-Analysts"
  description = "Analyst group for EDP IAM POC"
}

resource "okta_app_oauth" "poc_app" {
  label = "EDP IAM POC App"

  grant_types         = ["authorization_code"]
  redirect_uris       = ["https://localhost/callback"]
  response_types      = ["code"]
  token_endpoint_auth_method = "client_secret_post"
  application_type    = "web"
}
