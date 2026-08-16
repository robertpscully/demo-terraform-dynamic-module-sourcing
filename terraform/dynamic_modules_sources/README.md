# Dynamic Module Sourcing in Terraform v1.15

This Terraform demo demonstrates dynamic module sourcing, using local and const var values, a feature publicly available in terraform v1.15

The demo creates two instances of the `simple_module` child module. Both instances derive their source path dynamically. The root module outputs the value of each child module instance output to demonstrate the dynamic versioning.


## Terraform Folder Structure

The root module configuration is contained in the same folder as this file. (terraform/dynamic_module_sourcing/)

The child module sources are local to this configuration in the `modules` folder. The folders directly within `modules` represent a single child module.

Each subfolder beyond this represents a version of the same module, with the folder name containing this version.

In this demo, there is only one child module, `simple_module`, which has two different versions, as per below:

- `modules`
  - `simple_module`
    - `v0.1` — module version 0.1
    - `v0.2` — module version 0.2


## Child Module Logic

The module logic is simple. It reads a string value as a variable input and stores that value in a `terraform_data` reource. 

Each version of the module contains value in `locals.tf` string with the version value in it.

An output, `output_string` has a value containing  the value of `var.input_string`, suffixed with `local.child_module_version`.

## Root Module Logic

### Dynamic Module Source Configuration

The root module creates the module instances, with each using one of the following configurations: 
 - a static string from a local value, `module_version_local`
 - a terraform variable, `module_version` that has been defined with the `const` keyword

### Variable value assignment

The `module_version` variable has a default value of "v0.1".

This can be overridden by providing a value to `terraform.auto.tfvars` before running `terraform init`.

### Outputs

The output from each of the module intances are passed through to output values from the root module. 

In addition there are two outputs containing the value of `local.module_version_local` and `var.module_version`

## Usage

### Initial execution

This configuration doesn't require any authentication for operations. After cloning the repo, execute the following to deploy the default configuration.

For brevity, I have used `--auto-approve` below consistently.


```bash
cd terraform/dynamic_modules_sources
terraform init
terraform apply --auto-approve
```
Observe the output from the execution

### Update the const module instamce version

Execute the below script to create a `terraform.auto.tfvars` file with the version `v0.2`. Values in this file, for variables with the const keyword, can be read during `terraform init` to specify a module source and/or version.

```bash
NEW=v0.2
echo "module_version = \"${NEW}\"" > terraform.auto.tfvars
terraform init
terraform apply --auto-approve
```

## Conclusion

This demo shows how dynamic values can be provided to define a module source, even when executing in a remote pipeline, without having to provide literal strings for values, or require any editting of source code to execute.