env                = "dev"
region = "eu-west-1"
vpc_cidr           = "10.2.0.0/16"
private_subnets    = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
public_subnets     = ["10.2.4.0/24", "10.2.5.0/24", "10.2.6.0/24"]
instance_type_wg1  = "t2.micro"
instance_type_wg2  = "t2.micro"
rds_engine         = "sqlserver-ex"
rds_engine_version = "15.00.4198.2.v1"
rds_instance_class = "db.t3.small"
rds_storage_size   = "20"
rds_username       = "octopus" # This value will be same for 'dev' and 'prod' since we intended to use the same 'rds' instance for both the environments.
# rds_password = "value fetches from github secrets"
parameter_group_name = "default.sqlserver-ex-15.0"
map_users = [
  {
    userarn  = "arn:aws:iam::991006408214:user/jBoothapati"
    username = "jBoothapati"
    groups   = ["system:masters"]
  },
  {
    userarn  = "arn:aws:iam::991006408214:user/sMannem"
    username = "sMannem"
    groups   = ["system:masters"]
  },
  {
    userarn  = "arn:aws:iam::991006408214:user/aPanigrahi"
    username = "aPanigrahi"
    groups   = ["system:masters"]
  },
  {
    userarn  = "arn:aws:iam::991006408214:user/aleconte"
    username = "aleconte"
    groups   = ["system:masters"]
  }
]