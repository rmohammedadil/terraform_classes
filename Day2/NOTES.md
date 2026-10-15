# Day 2: Variables, provider aliases, and outputs

## What this configuration does

The configuration defines two AWS provider configurations and two EC2 resources. `example` uses the provider alias `usw1` in `us-west-1`; `example1` uses `usw2` in `us-west-2`. Both resources share the selected `instance_type`, while each receives its own regional AMI value.

## File walkthrough

- `provider.tf` declares the AWS provider aliases `aws.usw1` and `aws.usw2`, each with its own region.
- `variable.tf` declares the three inputs: `instance_type`, `ami`, and `ami_west2`.
- `main.tf` passes `var.ami` and `var.instance_type` to the first instance, and `var.ami_west2` and `var.instance_type` to the second. The explicit `provider` arguments bind each resource to its region-specific provider.
- `dev.tfvars` and `stage.tfvars` supply different values for those inputs. These files are not automatically selected by their names; choose one with `-var-file` when running Terraform.
- `output.tf` prints the public IP and instance ID of `example1` after apply. It does not output values for `example`.

## Run with an environment file

Run from the `Day2` directory and select one values file:

```sh
terraform init
terraform fmt
terraform validate
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

Use `stage.tfvars` in place of `dev.tfvars` to plan or apply the stage values. Review the plan before applying: each selected environment can request two EC2 instances.

## Review notes

- Each AMI must belong to the region of the provider used by its resource: `ami` for `us-west-1`, and `ami_west2` for `us-west-2`. Check that the selected environment values match those regions and are usable in the target account.
- The `t8i.micro` stage value must be supported for the intended account and region. Confirm availability in the plan or AWS before applying.
- The output named `instnace_id` is misspelled. Renaming it to `instance_id` would make the output easier to discover; update any consumers at the same time.
- `public_ip_output` refers to `example1`, so only the west-region instance's public IP is returned.
- Consider typing variables as `string`, defining required provider/version constraints, and keeping shared Terraform state in a protected backend.

