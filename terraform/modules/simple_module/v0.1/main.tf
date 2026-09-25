resource "terraform_data" "module_source_info" {
  input = "${var.version_source} [${local.child_module_version}]"
}