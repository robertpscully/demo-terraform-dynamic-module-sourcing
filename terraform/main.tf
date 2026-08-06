module "simple_module_from_local" {
  source = "./modules/simple_module_${local.module_version}"
  input_string = "Robert"
}

module "simple_module_from_const" {
  source = "./modules/simple_module_${var.module_version}"
  input_string = "static value"
}

