resource "aws_db_subnet_group" "this" {

  name = "three-tier-db-subnet-group"

  subnet_ids = var.subnet_ids

  tags = {
    Name = "DB-Subnet-Group"
  }
}

# RDS instance

resource "aws_db_instance" "RDS" {

  identifier = "three-tier-db"

  allocated_storage = var.allocated_storage

  engine = var.db_engine

  engine_version = var.db_engine_version

  instance_class = var.db_instance_class

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  publicly_accessible = false

  skip_final_snapshot = true

  multi_az = false

  storage_type = "gp3"

  tags = {
    Name = "Three-Tier-RDS"
  }
}
