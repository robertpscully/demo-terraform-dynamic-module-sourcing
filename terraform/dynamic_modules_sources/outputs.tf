
output "simple_module_with_version_from_local" {
  value = module.simple_module_with_version_from_local.output_string
}

output "simple_module_with_version_from_const" {
  value = module.simple_module_with_version_from_const.output_string
}

output "module_version_as_read_from_local" {
  value = local.module_version
}
output "module_version_as_read_from_const" {
  value = var.module_version
}
