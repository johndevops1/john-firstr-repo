resource "aws_instance" "example-1" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name	= "Devops-key"
  subnet_id = aws_subnet.crate-subnet.id
  tags = {
    "Name" = "terraform-launch-dev"
  }
}