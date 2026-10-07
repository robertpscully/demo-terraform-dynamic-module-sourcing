# demo-terraform-dynamic-module-sourcing

A demo Terraform repository showing dynamic module sourcing that can be executed in a local context, and a separate Terraform Cloud configuration to show how these variables can be provided in a managed workflow scenario

## Repository layout

- `terraform/dynamic_modules_sources/` - root config for the dynamic module sourcing example.
- `terraform/modules/` - local module versions used by the example.
- `terraform/hcpt/` - Terraform code that manages HCP Terraform resources that will execute the demo code in a VCS workflow

## Usage

Please see the dedicated README.md files in each folder for usage.


## Documentation workflow

A GitHub Actions workflow is configured in `.github/workflows/tfdocs.yml` to run `terraform-docs` against selected paths in the `terraform` directory.

The `terraform/dynamic_module_sourcing` folder is excluded from this action as terraform-docs does not currently support features of terraform 1.15 in use in this repository.
