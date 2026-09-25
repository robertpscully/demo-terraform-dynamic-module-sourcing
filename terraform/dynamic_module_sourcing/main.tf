module "simple_module_with_version_from_environment_const_var" {
  source         = "../modules/simple_module/${local.environment_version_map[var.environment]}"
  version_source = "var.environment const from ${var.environment_source} (${var.environment}) =>"
}

module "simple_module_with_version_from_module_version_const_var" {
  source         = "../modules/simple_module/${var.module_version}"
  version_source = "var.module_version const from ${var.module_version_source}"
}

module "simple_module_with_version_from_complex_environment_const_var" {
  source         = "../modules/simple_module/${var.complex_environment.version}"
  version_source = "var.complex_environment.version const from ${var.complex_environment.source}"
}

