# HCP Terraform Demo for Dynamic Module Sourcing

This is a companion HCP Terraform Workflow that can be deployed into any HCP Terraform organization.

## Prerequisites and Assumptions

Describing the operations of HCP Terrafrom, excluding specifics for this demo, is out of scope for this repository.

This deployment makes no assumption of any management layer that may be in place in your organization for deploying and configuring projects and/or workspaces.

This deployment makes assumptions regarding the level of access you many have to an organization with regards to user, team or organization tokens.

The configuration in this demo is intended to be deployed from your local environment, using one of the following: 
 - an Organization Token
 - any Team Token for a Team with organization permission to Manage Projects,
 - a User Yoken for a user who is a member of any Team Token for a Team with organization permission to Manage Projects

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.53 |

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
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | The GitHub App installation ID in HCP Terraform linked to the GitHub account or org. with access to this repo | `string` | n/a | yes |
| <a name="input_hcpt_org"></a> [hcpt\_org](#input\_hcpt\_org) | The name of the TFE organization to create the workspace in. | `string` | n/a | yes |
| <a name="input_hcpt_vcs_branch"></a> [hcpt\_vcs\_branch](#input\_hcpt\_vcs\_branch) | The VCS branch for the Terraform Cloud workspace. | `string` | `"main"` | no |
| <a name="input_hcpt_vcs_repo_identifier"></a> [hcpt\_vcs\_repo\_identifier](#input\_hcpt\_vcs\_repo\_identifier) | The VCS repo identifier for the Terraform Cloud workspace, e.g. github.com/org/repo. | `string` | `"robertpscully/demo-terraform-dynamic-module-sourcing"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

# Usage

Login to HCP Terraform using the terraform CLI to be able to create the resources


>[!WARNING]
> 
>DON'T DELETE THE `package.json` file!

[!TIP]
> [!TIP]
> S


```bash

```