output "ec2-ip" {
    value = module.ec2_instance.public-ip-address 
}