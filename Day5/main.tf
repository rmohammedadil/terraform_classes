provider "aws" {
    region = "us-west-2"
}

variable "bucket_perfix" {
    description = "Unique prefix for the lab bucket"
    type =  string  
}

resource "aws_s3_bucket" "demo" {
    count = 3

    bucket = "&{var.bucket_perfix}-${count.index}"

    tags = {
        Environment = "learning"
        createdBy = "Adil"    
        }  
}



output "bucket_names" {
    value = aws_s3_bucket.demo[*].bucket  
}