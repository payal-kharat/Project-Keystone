########################################
# DB Subnet Group
########################################

resource "aws_db_subnet_group" "this" {

  name = "${var.project_name}-db-subnet-group"

  subnet_ids = var.private_db_subnet_ids

  tags = {

    Name = "${var.project_name}-db-subnet-group"

  }

}

########################################
# MySQL RDS
########################################

resource "aws_db_instance" "this" {

  identifier = var.db_identifier

  allocated_storage = var.allocated_storage

  engine = "mysql"

  #engine_version = var.engine_version

  instance_class = var.db_instance_class

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [

    var.rds_sg_id

  ]

  publicly_accessible = false

  multi_az = false

  skip_final_snapshot = true

  deletion_protection = false

  storage_encrypted = false

  backup_retention_period = 0

  tags = {

    Name = var.db_identifier

  }

}