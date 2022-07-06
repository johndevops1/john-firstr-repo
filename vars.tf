variable "env" {}
variable "instance_type_wg1" {}
variable "instance_type_wg2" {}
variable "rds_engine" {}
variable "rds_instance_class" {}
variable "rds_username" {}
variable "rds_password" {}
variable "parameter_group_name" {}
variable "vpc_cidr" {}
variable "private_subnets" { type = list(any) }
variable "public_subnets" { type = list(any) }
