
resource "aws_db_subnet_group" "this_subnet_group" {
  name       = "${var.PROJECT_NAME}-db-subnet-group"
  subnet_ids = var.PRIVATE_DB_SUBNET_IDS
  tags = {
    Name = "${var.PROJECT_NAME}-db-subnet-group"
  }
}



resource "aws_db_instance" "this_db_instance" {
  identifier        = var.DB_IDENTIFIER
  allocated_storage = var.ALLOCATED_STORAGE
  engine            = "mysql"
  #engine_version = var.engine_version
  instance_class       = var.DB_INSTANCE_CLASS
  db_name              = var.DB_NAME
  username             = var.DB_USERNAME
  password             = var.DB_PASSWORD
  db_subnet_group_name = aws_db_subnet_group.this_subnet_group.name
  vpc_security_group_ids = [
    var.RDS_SG_ID
  ]

  publicly_accessible     = false
  multi_az                = false
  skip_final_snapshot     = true
  deletion_protection     = false
  storage_encrypted       = false
  backup_retention_period = 0
  tags = {
    Name = var.DB_IDENTIFIER
  }
}