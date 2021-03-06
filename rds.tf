resource "aws_db_subnet_group" "octopus-rds-subnet-group" {
  name        = "octopus-rds-subnet-${var.env}"
  description = "Subnet attaching to this RDS instance"
  subnet_ids  = module.vpc.private_subnets
  tags = {
    Name    = "octopus-rds-subnet-${var.env}"
    project = "octopus-${var.env}"
  }
}

resource "aws_db_instance" "octopus-rds" {
  identifier           = "octopus-rds-${var.env}"
  allocated_storage    = var.rds_storage_size
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  db_subnet_group_name = aws_db_subnet_group.octopus-rds-subnet-group.name
  #db_subnet_group_name    = aws_db_subnet_group.octopus-rds-subnet-group
  username                = var.rds_username
  password                = var.rds_password
  parameter_group_name    = var.parameter_group_name
  apply_immediately       = true
  backup_retention_period = 30
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds-securitygroup.id]
  license_model           = "license-included"
  tags                    = { project = "octopus-${var.env}" }
}

