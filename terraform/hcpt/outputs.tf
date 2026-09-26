output "workspace_id" {
  description = "The ID of the HCP Terraform workspace."
  value       = tfe_workspace.dynamic_module_source_workspace.id
}

output "project_id" {
  description = "The ID of the HCP Terraform project."
  value       = tfe_project.dynamic_module_source_project.id
}

output "project_url" {
  description = "Link to the HCP Terraform project in the UI."
  value       = "https://app.terraform.io/app/${var.hcpt_org}/projects/${tfe_project.dynamic_module_source_project.id}"
}

output "workspace_url" {
  description = "Link to the HCP Terraform workspace in the UI."
  value       = tfe_workspace.dynamic_module_source_workspace.html_url
}