# Day 3 concepts: Terraform modules

## Root and child modules

Every Terraform working directory is a **root module**. A `module` block calls another module, here the local directory `./module/ec2_instance`. The child module groups related configuration so it can be called with different inputs and reused by other root modules.

## Module inputs

The caller passes values in the module block:

- `ami_value = var.ami-main`
- `instance_type_value = var.instance_type_main`

The child declares matching variables. The input names on the left must match the variable names declared inside the child module; the expressions on the right are values from the root module.

## Module outputs

The child output exposes `aws_instance.example.public_ip`. The caller reads that value through `module.ec2_instance.public-ip-address`, and the root output publishes it to the user. This input/output boundary is the module's interface.

## Provider configuration and reuse

Provider configurations are normally owned by the root module. A reusable child module should state which provider it requires and use the provider supplied by its caller. Keeping region and authentication choices at the root lets callers choose a default or aliased provider without embedding account-specific setup inside the module.

## Module source paths

The `source` path is relative to the calling module directory. A local path is useful for modules stored alongside the configuration. A module's variables, resources, and outputs live in that child directory and are evaluated as part of the same Terraform plan.

