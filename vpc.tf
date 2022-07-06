data "aws_availability_zones" "available" {}

locals {
  cluster_name = "Octopus-eks-${var.env}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  count = length(var.private_subnets)

  name                 = "Octopus-${var.env}"
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = element(var.private_subnets,count.index)
  public_subnets       = element(var.public_subnets,count.index)
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluser/${local.cluster_name}" = "shared"
    "Project"                                    = "Octopus-${var.env}"
  }

  public_subnet_tags = {
    "kubernetes.io/cluser/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                     = "1"
    "Project"                                    = "Octopus-${var.env}"
  }

  private_subnet_tags = {
    "kubernetes.io/cluser/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                     = "1"
    "Project"                                    = "Octopus-${var.env}"
  }
}