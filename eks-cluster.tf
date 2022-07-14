module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  tags            = { project = "octopus-${var.env}" }


  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 30
  }

  node_groups = {
    octopus = {
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_types = ["t3.medium"]
      k8s_labels = {
        octopus = "managed_node_groups"
      }
      additional_tags = {
        project = "octopus-${var.env}"
      }
      update_config = {
        max_unavailable_percentage = 50 # or set `max_unavailable`
      }
    }
  }

  manage_aws_auth = true

  map_users = var.map_users



  # workers_group_defaults = {
  #   root_volume_type = "gp2"
  # }

  # worker_groups = [
  #   {
  #     name                         = "worker-group-1"
  #     instance_type                = var.instance_type_wg1
  #     additional_security_group_id = [aws_security_group.worker_group_mgmt_one.id]
  #     asg_desired_capacity         = 1
  #     root_volume_size             = 10
  #     # tags                         = { Project = "Octopus-${var.env}" }
  #   },
  #   {
  #     name                         = "worker-group-2"
  #     instance_type                = var.instance_type_wg2
  #     additional_security_group_id = [aws_security_group.worker_group_mgmt_two.id]
  #     asg_desired_capacity         = 1
  #     root_volume_size             = 10
  #     # tags                         = { Project = "Octopus-${var.env}" }
  #   }
  # ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id

}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}