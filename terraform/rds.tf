resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db-credentials"
}
# Note: this secret was updated manually in the console to have the correct username/password for the db

data "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
}

resource "aws_db_instance" "peregrine" {
  identifier                 = "prd-peregrine"
  allocated_storage          = 400
  engine                     = "postgres"
  engine_version             = "14.6"
  instance_class             = "db.m6i.large"
  db_name                    = "peregrine"
  username                   = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["username"]
  password                   = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["password"]
  publicly_accessible        = false
  storage_type               = "io1"
  iops                       = 3000
  storage_encrypted          = true
  kms_key_id                 = "arn:aws:kms:us-east-1:905418199768:key/6a4b89c1-176a-48e4-8070-b0663e22c8c9"
  db_subnet_group_name       = "default-vpc-02c2f4f5c9cc2c054"
  vpc_security_group_ids     = [aws_security_group.database_sg.id]
  parameter_group_name       = "default.postgres14"
  option_group_name          = "default:postgres-14"
  auto_minor_version_upgrade = true
  multi_az                   = false
  storage_throughput         = 0
  ca_cert_identifier         = "rds-ca-2019"
  port                       = 5432
  copy_tags_to_snapshot      = false
  skip_final_snapshot        = false
}
