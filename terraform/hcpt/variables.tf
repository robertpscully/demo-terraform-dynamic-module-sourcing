variable "hcpt_org" {
  description = "The name of the TFE organization to create the workspace in."
  type        = string
}

variable "hcpt_vcs_repo_identifier" {
  description = "The VCS repo identifier for the Terraform Cloud workspace, e.g. github.com/org/repo."
  type        = string
  default     = "robertpscully/demo-terraform-dynamic-module-sourcing"
}

variable "hcpt_vcs_branch" {
  description = "The VCS branch for the Terraform Cloud workspace."
  type        = string
  default     = "main"
}

variable "github_app_installation_id" {
  description = "The GitHub App installation ID in HCP Terraform linked to the GitHub account or org."
  type        = string
  sensitive   = true
}