# HCP Terraform Demo for Dynamic Module Sourcing

A companion HCP Terraform workflow that can be deployed into any HCP Terraform organization to deploy the [dynamic module sourcing demo](../dynamic_modules_sources).

## Resources Created

 - An HCP Terraform Project
 - An HCP Terraform Workspace in this Project
   - Optionally: A VCS-connection block for this Workspace, which is linked to the demo code contained in this repository
 - An HCP Terraform Workspace Variable named `module_version`
   - This is a terraform variable with a non-sensitive value
   - The default value for this variable is `v0.1`

Outputs `project_id`, `project_url`, `workspace_id`, and `workspace_url` are provided so the created project and workspace can be linked to directly from the UI — see the Outputs table below.

## Prerequisites and Assumptions

Explaining the operations of HCP Terraform itself is out of scope.

- No organization management / IAC landing-zone layer is assumed for creating projects or workspaces.

- The following assumptions are made about VCS connections that are available in your HCP Terraform organization.

  - This demo can make use of a GitHub App Installation to connect the Workspace to this repository.

  - When specifying the App Installation ID for the [GitHub.com (GitHub App) VCS Provider](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github-app) linked to a user, the HCP Terraform token used to vend resources **must** belong to the same user.
  
  - Using a user GitHub App Installation with any other token will result in an error when trying to create the VCS configuration for the Workspace.

- Providing no value (an empty string) for the GitHub APP Installation ID will skip configuring the VCS connection for the workspace.

  - This is a valid pattern when using a **Team Token** or an **Organization Token**

  - A user with sufficient privilege can manually configure the VCS connection after the workspace has been created.

- Any HCP Terraform Token that is used must be linked to a User or team with the **Manage Projects** permission. 

- An Organization Token can also be used.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15 |
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

| Name | Description |
| ---- | ----------- |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The ID of the HCP Terraform project. |
| <a name="output_project_url"></a> [project\_url](#output\_project\_url) | Link to the HCP Terraform project in the UI. |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of the HCP Terraform workspace. |
| <a name="output_workspace_url"></a> [workspace\_url](#output\_workspace\_url) | Link to the HCP Terraform workspace in the UI. |
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

# Executing the HCP Terraform Workspace

After the workspace is created and connected to this repository, all execution will be performed using HCP Terraform Cloud Runners via the [UI and VCS-driven run](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/ui) workflow.

# Cleanup

When finished with this demo, the resources can be cleaned up as follows:

### Destroy resources in the remote workspace

Proceed to the 'Destruction and deletion' page in the settings menu for your workspace.

Execute a `destroy` plan and apply to delete the resources.

When complete, from your local environment execute the command below to destroy the workspace and project created for this demo.
