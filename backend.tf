terraform {
  backend "s3" {
    bucket = "octopus-dev-infra-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-dev-state-locking"
    encrypt = true
  }
}

provider "aws" {
    region = "us-east-2"
}