

resource "tfe_project" "module_source_demo" {
  name         = "Module Source Demo"
  organization = var.hcpt_org
}

resource "tfe_workspace" "dynamic_module_source_workspace" {
  name                 = "dynamic-module-sourcing-demo"
  organization         = var.hcpt_org
  project_id           = tfe_project.module_source_demo.id
  file_triggers_enabled = true
  trigger_prefixes     = ["terraform/dynamic_modules_sources"]
  speculative_enabled  = true
  allow_destroy_plan   = true

  vcs_repo {
    identifier                 = var.hcpt_vcs_repo_identifier
    branch                     = var.hcpt_vcs_branch
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

