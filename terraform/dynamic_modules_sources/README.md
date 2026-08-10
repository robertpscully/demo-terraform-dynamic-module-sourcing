# dynamic_modules_sources

This Terraform folder demonstrates dynamic module loading from local module versions.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

Files:

- `locals.tf` — defines `local.module_version` for the example.
- `main.tf` — loads two modules using dynamic local paths.
- `variables.tf` — declares input variables.
- `outputs.tf` — exposes module outputs.
- `vars.tfvars` — example variable values.

Use this folder directly for Terraform CLI work:

```bash
cd terraform/dynamic_modules_sources
terraform init
terraform plan
```

