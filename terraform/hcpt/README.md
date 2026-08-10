# hcpt

This folder contains Terraform configuration that manages a Terraform Cloud workspace resource for the repository.

This implementation doesn't presuppose any existing deployment management framework for HCP Terraform.



It is configured to keep Terraform state locally in `terraform.tfstate` while managing a `tfe_workspace` and workspace variables.

Use this folder to deploy or update the Terraform Cloud workspace metadata for the repo:

```bash
cd terraform/hcpt
terraform init
terraform plan
terraform apply
```

The workspace is configured to point at the repository folder `terraform/dynamic_modules_sources`.


<!-- BEGIN_TF_DOCS -->
{{ .Content }}
<!-- END_TF_DOCS -->