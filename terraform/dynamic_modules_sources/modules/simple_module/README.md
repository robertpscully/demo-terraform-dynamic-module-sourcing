# Child Modules

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

Each module includes:

- `main.tf` — single `terraform_data` resource 
- `variables.tf` — single input variable `input_string` 
- `output.tf` — defines a single output `output_string` with content as above
- `locals.tf` — defines the module version in `local.child_module_version`, where this value maps to its containing folder name
