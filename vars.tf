variable "env" {}
variable "region" {}
variable "instance_type_wg1" {}
variable "instance_type_wg2" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_storage_size" {}
variable "parameter_group_name" {}
variable "vpc_cidr" {}
variable "private_subnets" { type = list(any) }
variable "public_subnets" { type = list(any) }
variable "map_users" {}