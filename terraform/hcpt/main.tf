terraform {
  required_version = ">= 1.5"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.53"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "tfe" {}

resource "tfe_workspace" "dynamic_module_source_workspace" {
  name         = "dynamic-module-sourcing-demo"
  organization = var.hcpt_org

  vcs_repo {
    identifier = var.hcpt_vcs_repo_identifier
    branch     = var.hcpt_vcs_branch
    github_app_installation_id = var.github_app_installation_id
  }

  working_directory = "terraform/dynamic_modules_sources"
}

resource "tfe_variable" "module_version" {
  key          = "module_version"
  value        = "0.2"
  category     = "terraform"
  workspace_id = tfe_workspace.dynamic_module_source_workspace.id
  sensitive    = false
  hcl          = false
}

