provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name	= "Devops-key"
  tags = {
    "Name" = "terraform-launch"
  }
}

resource "aws_s3_bucket" "creating_bucket" {
  bucket = "johndevopsuk1"
  tags = {
    "Name" = "testing"
     }
  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }
   
}


#resource "aws_s3_bucket" "octopus_infra_s3_dev" {
#  bucket = "octopus-dev-infra-terraform-state"
#  lifecycle {
#    prevent_destroy = true
#  }
#  versioning {
#    enabled = true
#  }
#  server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        sse_algorithm = "AES256"
#      }
#    }
#  }
#}
