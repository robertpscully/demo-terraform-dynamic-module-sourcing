module "simple_module_with_version_from_local" {
  source       = "./modules/simple_module/${local.module_version}"
  input_string = "module version from local"
}

module "simple_module_with_version_from_const" {
  source       = "./modules/simple_module/${var.module_version}"
  input_string = "module version from const var"
}

