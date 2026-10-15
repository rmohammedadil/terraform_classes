output "public_ip_output" {
    description = "public ip of example1"
    value = aws_instance.example1.public_ip
}

output "instnace_id" {
  description = "instance id"
  value = aws_instance.example1.id  
}
