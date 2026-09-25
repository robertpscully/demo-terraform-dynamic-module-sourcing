# Child Modules

The child module sources are local to the demo configurations, under `terraform/modules/`. Each folder directly within `modules` is a single child module. Each subfolder below that is one **version** of that module, and the folder name *is* the version string (`v0.1`, `v0.2`, `v0.3`).

This layout is what makes dynamic module sourcing observable: the root module builds a `source` path such as `../modules/simple_module/${var.module_version}`, so changing an input value selects a different version folder.

In this demo there is one child module, `simple_module`, with three versions:

- `modules`
  - `simple_module`
    - `v0.1` — module version 0.1
    - `v0.2` — module version 0.2
    - `v0.3` — module version 0.3

## Child Module Logic

The logic is deliberately minimal. Each version:

- takes one input variable, `version_source` (`string`) — a caller-supplied description of *where* the selected version came from (which variable, which file).
- defines `local.child_module_version` in `locals.tf`, hard-coded to match the containing folder name.
- creates a single `terraform_data.module_source_info` resource whose `input` is `"${var.version_source} [${local.child_module_version}]"`.
- exposes one output, `module_configuration`, an object:

  ```hcl
  {
    module_source_info = terraform_data.module_source_info.output  # "<version_source> [vX.Y]"
    module_version     = local.child_module_version                # "vX.Y"
  }
  ```

Because `local.child_module_version` differs per folder, the root module's outputs prove which version each instance actually resolved to.

## Files in each version

- `main.tf` — single `terraform_data.module_source_info` resource
- `variables.tf` — single input variable `version_source`
- `output.tf` — single output `module_configuration` (object described above)
- `locals.tf` — `local.child_module_version`, mapped to the folder name
- `README.md` — terraform-docs generated reference
