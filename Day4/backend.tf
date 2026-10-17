terraform {
  backend "s3" {
    bucket = "terraform-state-devops-demo-123456"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    # use_lockfile = true
  }
  
}