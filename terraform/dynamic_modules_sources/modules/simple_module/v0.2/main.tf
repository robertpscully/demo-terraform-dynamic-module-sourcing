resource "terraform_data" "simple_data" {
  input = "${var.input_string} [${local.child_module_version}]"
}