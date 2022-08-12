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
#
#resource "aws_dynamodb_table" "octopus_terraform_locks_dev" {
#  name         = "terraform-dev-state-locking"
#  billing_mode = "PAY_PER_REQUEST"
#  hash_key     = "LockID"
#
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#}