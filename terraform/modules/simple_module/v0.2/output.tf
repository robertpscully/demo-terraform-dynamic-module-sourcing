output "module_configuration" {
  value       = {
    module_source_info = terraform_data.module_source_info.output
    module_version     = local.child_module_version
  }
  description = "Returns the value of the terraform_data.module_source_info object: var.version_source, suffixed with the value of local.child_module_version (v0.2 in this module)."
}