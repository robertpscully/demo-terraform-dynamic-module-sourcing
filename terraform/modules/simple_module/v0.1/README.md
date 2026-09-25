<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [terraform_data.module_source_info](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_version_source"></a> [version\_source](#input\_version\_source) | A simple input string variable describing the source of the module configuration | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_module_configuration"></a> [module\_configuration](#output\_module\_configuration) | Returns the value of the terraform\_data.module\_source\_info object: var.version\_source, suffixed with the value of local.child\_module\_version (v0.1 in this module). |
<!-- END_TF_DOCS -->