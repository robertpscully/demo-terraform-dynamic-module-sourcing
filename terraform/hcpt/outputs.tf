output "workspace_url" {
  description = "The URL of the created Terraform Cloud workspace."
  value       = format("https://app.terraform.io/app/%s/workspaces/%s", var.hcpt_org, tfe_workspace.dynamic_module_source_workspace.name)
}
