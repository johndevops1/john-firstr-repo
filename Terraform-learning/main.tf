provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "johndevops-terraform-backend"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform-dev-state-locking"
    encrypt = true
  }
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name	= "Devops-key"
  #vpc_security_group_ids = aws_vpc.create-VPC.default_security_group_id
  tags = {
    "Name" = "terraform-launch-dev"
  }
}

resource "aws_vpc" "create-VPC" {
  tags = {
    "Name" = "dev-vpc"
  }
  cidr_block = var.cidr
}

resource "aws_subnet" "crate-subnet" {
  vpc_id     = aws_vpc.create-VPC.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "Main"
  }
}

output "vpc-security-group-name-id" {
  description = "vpc-security-id"
  value       = aws_vpc.create-VPC.default_security_group_id
}
