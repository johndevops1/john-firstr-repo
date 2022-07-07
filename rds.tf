resource "aws_db_subnet_group" "octopus-rds-subnet-group" {
  name        = "octopus rds subnet"
  description = "Subnet attaching to this RDS instance"
  subnet_ids  = module.vpc.private_subnets
  tags = {
    Name = "octopus rds subnet"
  }
}

resource "aws_db_instance" "octopus-rds" {
  identifier           = "octopus-rds"
  allocated_storage    = 10
  engine               = var.rds_engine
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
  tags                    = { Project = "Octopus-${var.env}" }
}

output "rds_endpoint_url" {
  description = "Get the rds endpoint value for connection string"
  value       = aws_db_instance.octopus-rds.address
}