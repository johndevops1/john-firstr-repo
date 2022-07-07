data "aws_availability_zones" "available" {}

locals {
  cluster_name = "octopus-eks-${var.env}" #need to raplacw with env 'Octopus-eks-${var.env}'
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  #count = length(var.private_subnets)

  name            = "octopus-${var.env}" #"octopus-vpc"
  cidr            = var.vpc_cidr         #"10.2.0.0/16"
  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets #["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"] #cidrsubnet("${var.vpc_cidr}", 8, 1)
  public_subnets  = var.public_subnets  #["10.2.4.0/24", "10.2.5.0/24", "10.2.6.0/24"] #cidrsubnet("${var.vpc_cidr}", 8, 2)
  #  private_subnets      = element(var.private_subnets, count.index)
  #  public_subnets       = element(var.public_subnets, count.index)
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluser/${local.cluster_name}" = "shared"
    "Project"                                    = "octopus-${var.env}"
  }

  public_subnet_tags = {
    "kubernetes.io/cluser/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                     = "1"
    "Project"                                    = "octopus-${var.env}"
  }

  private_subnet_tags = {
    "kubernetes.io/cluser/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                     = "1"
    "Project"                                    = "octopus-${var.env}"
  }
}