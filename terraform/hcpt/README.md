# HCP Terraform Demo for Dynamic Module Sourcing

A companion HCP Terraform workflow that can be deployed into any HCP Terraform organization to run the [dynamic module sourcing demo](../dynamic_modules_sourcing) as a VCS-driven workspace.

It creates a project, a VCS-connected workspace pointed at this repo, and seeds the `module_version` Terraform variable on that workspace. Using a VCS configuration lets HCP Terraform read the demo code directly from GitHub on each run, which keeps the demo root module free of any `backend` block.

## Prerequisites and Assumptions

Explaining HCP Terraform itself is out of scope here.

- No organization management / IAC landing-zone layer is assumed for creating projects or workspaces.
- An assumptions is made about VCS connections that are available in your HCP Terraform organization.
  -This demo makes use of a GitHub App Installation to connect the workspace to this repository.This affects the way in which this demo can connect to Assumptions are made about the token access you hold in the organization. Deploy this from your local environment with one of:
  - an **Organization Token**
  - a **Team Token** for a team with the org-level *Manage Projects* permission
  - a **User Token** for a user who is a member of a team with the org-level *Manage Projects* permission
- The VCS workflow requires a **GitHub App installation** in HCP Terraform connected to this repo. Its installation ID is passed via `var.github_app_installation_id` (marked sensitive).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.80 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [tfe_project.dynamic_module_source_project](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_variable.module_version](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.dynamic_module_source_workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | The GitHub App installation ID in HCP Terraform linked to the GitHub account or org. | `string` | n/a | yes |
| <a name="input_hcpt_org"></a> [hcpt\_org](#input\_hcpt\_org) | The name of the TFE organization to create the workspace in. | `string` | n/a | yes |
| <a name="input_hcpt_vcs_branch"></a> [hcpt\_vcs\_branch](#input\_hcpt\_vcs\_branch) | The VCS branch for the Terraform Cloud workspace. | `string` | `"main"` | no |
| <a name="input_hcpt_vcs_repo_identifier"></a> [hcpt\_vcs\_repo\_identifier](#input\_hcpt\_vcs\_repo\_identifier) | The VCS repo identifier for the Terraform Cloud workspace, e.g. github.com/org/repo. | `string` | `"robertpscully/demo-terraform-dynamic-module-sourcing"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## What gets created

| Resource | Detail |
| --- | --- |
| `tfe_project` | Project **"Dynamic Module Sourcing Demo"** in `var.hcpt_org` |
| `tfe_workspace` | Workspace **"dynamic-module-sourcing-demo"** in that project, VCS-connected to `var.hcpt_vcs_repo_identifier` on `var.hcpt_vcs_branch` via `var.github_app_installation_id`, `working_directory` set to the demo root module |
| `tfe_variable` | Terraform variable `module_version = "v0.1"` (category `terraform`, `hcl = false`) on the workspace, so the VCS run resolves the `const` module source |

# Usage

Authenticate the Terraform CLI to HCP Terraform, generate the required token and provide the value.

> [!WARNING]
>
> Treat all tokens as highly sensitive credentials.
>
> Use the least privilege necessary and the shortest TTL you can when operating with tokens locally.
>
> NEVER check any token into source control.

```bash
terraform login
```

Then deploy:

```bash
cd terraform/hcpt
terraform init
terraform plan -out plan.tfplan
```

Review the plan, then apply it:

```bash
terraform apply plan.tfplan
```

State is kept in a local backend (`terraform.tfstate` in this folder).

# Executing the code using HCP Terraform

After deploying the 
