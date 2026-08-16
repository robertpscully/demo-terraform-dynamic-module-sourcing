output "output_string" {
  value = terraform_data.simple_data.output
  description = "Returns the value of var.input_string, suffixed with the value of local.child_module_version (v0.1 in this module)."
}