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