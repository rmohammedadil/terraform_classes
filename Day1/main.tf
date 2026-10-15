provider "aws" {
  region     = "us-west-2"
}


resource "aws_instance" "web" {
  ami           = "ami-02167eae61967e403"
  instance_type = "t3.micro"
  key_name   = "terraform_key"
}

# resource "aws_instance" "demo" {
#   ami           = "ami-02167eae61967e403"
#   instance_type = "t3.micro"
#   key_name   = "terraform_key"
#   subnet_id =  "subnet-093893e9e700bced1"
# }

