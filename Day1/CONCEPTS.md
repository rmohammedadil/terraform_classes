# Day 1 concepts: Terraform basics

## Infrastructure as code

Terraform describes the desired infrastructure in configuration files. It compares that description with its state and the remote provider, then proposes actions to bring them into alignment. The configuration is declarative: it says what resource should exist, while Terraform determines the operations needed to reach that state.

## Provider and resource

- A **provider** is a plugin that translates Terraform operations into API calls for a platform such as AWS.
- A **provider configuration** supplies settings such as the AWS region. Authentication is generally provided separately.
- A **resource** represents an object Terraform manages. In `resource "aws_instance" "web"`, `aws_instance` is the resource type and `web` is its local name. Together they form the address `aws_instance.web`.

## Resource arguments

Arguments such as `ami`, `instance_type`, and `key_name` describe how the EC2 instance should be configured. Some values are literal strings; later examples can replace literals with variables and references to other resources.

## Plan, apply, and state

- `terraform init` installs the providers needed by the configuration.
- `terraform plan` previews the changes Terraform intends to make.
- `terraform apply` asks for approval and performs the planned changes.
- **State** maps Terraform resource addresses to real infrastructure objects. Treat state as sensitive operational data and store shared state in an appropriately protected backend for team use.

## Region-specific inputs

AWS AMI IDs and EC2 key pairs are regional. An AMI ID that works in one region generally cannot be assumed to work in another. Keep the provider region and the AMI/key-pair region aligned.

