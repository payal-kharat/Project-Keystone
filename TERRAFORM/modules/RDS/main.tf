resource "aws_db_subnet_group" "this_rds" {
  name       = "three-tier-db-subnet-group"
  subnet_ids = var.SUBNET_IDS

  tags = {
    Name = var.DB_SUBNET_GROUP_NAME
  }
}

# RDS instance

resource "aws_db_instance" "this_rds_instance" {
  identifier           = "three-tier-db"
  allocated_storage    = var.ALLOCATED_STORAGE
  engine               = var.DB_ENGINE
  engine_version       = var.DB_ENGINE_VERSION
  instance_class       = var.DB_INSTANCE_CLASS
  db_name              = var.DB_NAME
  username             = var.DB_USERNAME
  password             = var.DB_PASSWORD
  db_subnet_group_name = aws_db_subnet_group.this_rds.name

  vpc_security_group_ids = [
    var.SECURITY_GROUP_ID
  ]

  publicly_accessible = false
  skip_final_snapshot = true
  multi_az            = false
  storage_type        = var.DB_STORAGE_TYPE

  tags = {
    Name = var.DB_INSTANCE_NAME
  }
}
