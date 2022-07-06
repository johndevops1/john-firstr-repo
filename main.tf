resource "aws_instance" "my_test" {
  # Amazon Linux AMI
  ami           = "ami-02f3416038bdb17fb"
  instance_type = "t2.micro"
  tags = {
    Name                                  = "octopus-${var.env}"
    kubernetes.io / cluster / Octopus-eks = var.env
  }
}

variable "env" {}