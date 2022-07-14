terraform {
  backend "s3" {
    bucket = "octopus-infra-terraform-state"
    key    = "global/s3-workspace-test/terraform.tfstate"
    region = "eu-west-1"
    # dynamodb_table = "terraform-dev-state-locking"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-1"
}