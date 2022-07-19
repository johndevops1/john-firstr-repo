terraform {
  backend "s3" {
    bucket = "octopus-dev-infra-terraform-state1"
    key    = "global/s3-workspace-test/terraform.tfstate"
    region = "eu-west-1"
    # dynamodb_table = "terraform-dev-state-locking"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-1"
}