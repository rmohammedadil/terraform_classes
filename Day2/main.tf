
resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
  provider = aws.usw1  
}

resource "aws_instance" "example1" {
  ami = var.ami_west2
  instance_type = var.instance_type
  provider = aws.usw2  
}
