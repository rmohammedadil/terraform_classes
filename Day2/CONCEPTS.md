# Day 2 concepts: Reusable inputs and multiple provider configurations

## Input variables

An input variable gives a configuration a named value instead of embedding that value throughout the code. A variable block can specify its type, description, and optionally a default. Here, the AMIs and instance type are supplied from variable files.

## Variable files

A `.tfvars` file assigns concrete values to declared variables. Terraform automatically loads `terraform.tfvars` and `*.auto.tfvars`; files named `dev.tfvars` or `stage.tfvars` must be selected explicitly, for example with `-var-file=dev.tfvars`. This lets one configuration be planned with different environment values.

## Provider aliases

The default provider configuration is addressed as `aws`. An aliased configuration is addressed as `aws.<alias>`, such as `aws.usw1`. A resource's `provider` argument selects which configured provider instance manages it. This allows one root configuration to manage resources in more than one AWS region.

## Outputs and references

An output publishes a value calculated from a resource. The expression `aws_instance.example1.public_ip` reads an attribute from that resource; Terraform tracks the dependency automatically. Outputs can be displayed after apply or consumed by a parent module when this configuration is used as a module.

## Region and environment mapping

Provider aliases do not make an AMI portable between regions. Each AMI input must correspond to the provider selected for its resource. Keep the mapping explicit and verify it when adding regions or environment files.

