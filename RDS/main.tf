resource "aws_db_instance" "capstone" {
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_instance_name
  username             = var.username
  password             = var.postgres
  allocated_storage    = 20
  storage_type         = var.storage_type
  backup_retention_period = 7
  #final_snapshot_identifier = var.snapshot_ID
  snapshot_identifier   = var.snapshot_ID
}

