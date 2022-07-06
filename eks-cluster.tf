locals {
  cluster_name = "Octopus-eks-${var.env}"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  tags            = { Project = "Octopus-${var.env}" }

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  workers_groups = [
    {
      name                         = "worker-group-1"
      instance_type                = var.instance_type_wg1
      additional_security_group_id = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity         = 1
      root_volume_size             = 10
      tags                         = { Project = "Octopus-${var.env}" }
    },
    {
      name                         = "worker-group-2"
      instance_type                = var.instance_type_wg2
      additional_security_group_id = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity         = 1
      root_volume_size             = 10
      tags                         = { Project = "Octopus-${var.env}" }
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id

}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}