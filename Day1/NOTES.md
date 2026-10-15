# Day 1: One EC2 instance

## What this configuration does

`main.tf` configures the AWS provider for `us-west-2` and declares one EC2 instance named `web`. The instance uses the configured AMI, the `t3.micro` instance type, and the EC2 key pair named `terraform_key`. The commented-out `demo` resource is an example only; Terraform ignores it while it remains commented out.

## File walkthrough

- `provider "aws"`: selects the AWS provider and its default region. Credentials are normally supplied outside this file, such as through the AWS shared credentials file, environment variables, or an assigned role.
- `resource "aws_instance" "web"`: declares the desired instance. Its Terraform address is `aws_instance.web`.
- `ami`, `instance_type`, and `key_name`: configure the image, size, and login key pair. The AMI must be available in `us-west-2`, and the key pair must exist in the AWS account and region.
- The commented `demo` block shows how a subnet could be assigned with `subnet_id`; it does not create another instance as written.

## Typical workflow

Run these commands from the `Day1` directory:

```sh
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Review the plan before applying it. Applying this configuration can create a billable AWS resource. Terraform state records the resource Terraform manages, so keep state files private and do not commit them.

## Review notes

- The AMI and key pair are hard-coded. For reuse, make them input variables and pass environment-specific values separately.
- There is no explicit VPC, subnet, or security group in this resource. The AWS provider and account defaults determine placement and networking behavior; check the plan and AWS defaults for the target account.
- The file does not pin Terraform or AWS provider versions. A production configuration should declare compatible versions and commit the provider lock file.

