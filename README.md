# demo-terraform-dynamic-module-sourcing

A demo Terraform repository showing dynamic module sourcing that can be executed in a local context, and a separate Terraform Cloud configuration to show how these variables can be provided in a managed workflow scenario

## Repository layout

- `terraform/dynamic_modules_sources/` - root config for the dynamic module sourcing example.
- `terraform/modules/` - local module versions used by the example.
- `terraform/hcpt/` - Terraform code that manages HCP Terraform resources that will execute the demo code in a VCS workflow

## Usage

Please see the dedicated README.md files in each folder for usage.


## Documentation workflow

A GitHub Actions workflow is configured in `.github/workflows/tfdocs.yml` to run `terraform-docs` against the `terraform/dynamic_modules_sources` folder.

## Notes

- The workflow does not commit generated docs automatically; it validates that `terraform-docs` can generate documentation for the repo.
- Use the `terraform-docs` command locally to generate docs manually if needed:
  ```bash
  terraform-docs markdown table terraform/dynamic_modules_sources
  ```
