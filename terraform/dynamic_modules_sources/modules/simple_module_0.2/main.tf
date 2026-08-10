resource "terraform_data" "simple_data" {
  input = "Hello, ${var.input_string} [${local.simple_static_suffix}]"
}