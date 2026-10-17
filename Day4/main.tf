terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo" {
  bucket = "demo-bucket-adil-12334445"

  tags = {
    Name = "remote backend lab"
  }
}

output "demo-bucket-name" {
  value = aws_s3_bucket.demo.bucket
}


