# Day 3: A reusable EC2 module

## What this configuration does

The root module calls the child module at `./module/ec2_instance`. It passes an AMI and instance type into the child module. The child creates one EC2 instance in `us-east-1`, requests a public IP association, and returns the instance's public IP. The root output exposes that IP.

## File walkthrough

- `provider.tf` configures the root AWS provider for `us-east-1`.
- `variables.tf` supplies default values for `ami-main` and `instance_type_main`.
- `main.tf` calls the child module and maps root input values to the module's `ami_value` and `instance_type_value` inputs.
- `module/ec2_instance/variables.tf` defines the child module's inputs.
- `module/ec2_instance/main.tf` configures AWS and declares `aws_instance.example` with the supplied AMI and instance type.
- `module/ec2_instance/output.tf` exports the created instance's public IP.
- `output.tf` passes the child module's public IP through as a root-module output named `ec2-ip`.

## Typical workflow

Run from the `Day3` directory:

```sh
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Review the plan before applying. The configuration can create a billable EC2 instance. The public IP association also depends on the selected subnet and network having the required public addressing and routing behavior.

## Review notes

- `module/ec2_instance/main.tf` contains its own AWS provider configuration even though the root also configures AWS. Reusable child modules are usually better when they declare the provider requirement but receive provider configuration from the root. This keeps region and credentials in one place and lets callers select provider aliases.
- The child module's variables do not declare types. Declaring both as `string` improves validation and makes the module interface clearer.
- The root configuration has no Terraform/provider version constraints. Add compatible version constraints and commit the generated provider lock file for repeatable initialization.
- The module requests public IP association, but a public address alone does not guarantee internet reachability; subnet routing and security rules also matter.

