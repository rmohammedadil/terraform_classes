

module "ec2_instance" {
  source = "./module/ec2_instance"
  ami_value = var.ami-main
  instance_type_value = var.instance_type_main
}


