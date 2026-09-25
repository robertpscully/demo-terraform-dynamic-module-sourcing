# Dynamic Module Sourcing in Terraform

This demo shows **dynamic module sourcing**, configuring a module `source` path from input values instead of a hard-coded literal. This is achieved using `const` variables, a feature available in Terraform v1.15+.

The root module creates three instances of the local `simple_module` child module.

Every instance derives its `source` path using a variation of a `const` variable usage:
 - directly with a `const` variable
 - via a `local` map lookup, using a `const` varible as key
 - via an attribute of a complex `const` variable ojbect

The root module then outputs each instance's `module_configuration`, so you can see which version each path resolved to.

> [!NOTE]
>
> This configuration deliberately sets no `backend` block.
>
> It is intended to be able to run unchanged both locally and through an HCP Terraform VCS workflow. See [`../hcpt`](../hcpt) for the companion workspace configuration.

> [!NOTE]
>
> `terraform-docs` cannot yet parse `const` variables / dynamic `source` expressions, so this README has no injected `BEGIN_TF_DOCS` block. The Inputs / Outputs below are maintained by hand.

## Folder structure

```
terraform/
  dynamic_modules_sources_simple/   # this root module
  modules/
    simple_module/
      v0.1/  v0.2/  v0.3/           # one folder per module version
  configuration/
    module_config.tfvars            # additional var-file, passed explicitly
```

The child module sources are `../modules/simple_module/<version>`. See [`../modules/simple_module/README.md`](../modules/simple_module/README.md) for the child module logic.

## `const` variables

Dynamic `source` values must be resolvable at `terraform init`, so every variable used in a `source` path is declared with `const = true`. 

`const` values are read from `*.auto.tfvars` / `terraform.tfvars` (or an explicit `-var-file`) at init time; they cannot be set from `-var` on the CLI or from the environment.

Each "version" `const` is paired with a plain (non-`const`) `*_source` companion variable. The companion carries a human-readable note of where the version came from (e.g. terraform.tfvars, variable default etc.)

This is intended to show how const variable values are set.

## Root module logic

There are three module instances configured in [`main.tf`](main.tf), one per sourcing style:

| Module instance | `source` expression | Drives version from |
| --- | --- | --- |
| `simple_module_with_version_from_environment_const_var` | `../modules/simple_module/${local.environment_version_map[var.environment]}` | `var.environment` (`const`) mapped through `local.environment_version_map` |
| `simple_module_with_version_from_module_version_const_var` | `../modules/simple_module/${var.module_version}` | `var.module_version` (`const`) directly |
| `simple_module_with_version_from_complex_environment_const_var` | `../modules/simple_module/${var.complex_environment.version}` | `var.complex_environment.version` — a `const` object attribute |


The mappings of environment values against version are defined in  `local.environment_version_map` in  ([`locals.tf`](locals.tf)) as follows:

| `var.environment` | Module version |
| --- | --- |
| `DEV` | `v0.3` |
| `TEST` | `v0.2` |
| `PROD` | `v0.1` |

### Inputs

| Name | Type | `const` | Default | Description |
| --- | --- | :---: | --- | --- |
| `module_version` | `string` | yes | `"v0.1"` | Version folder for the direct-`const` instance |
| `module_version_source` | `string` | no | `"root module default"` | Provenance note for `module_version` |
| `environment` | `string` | yes | `"v0.3"` | Environment key; validated against `DEV` / `TEST` / `PROD` |
| `environment_source` | `string` | no | `"root module default"` | Provenance note for `environment` |
| `complex_environment` | `object({ version, source })` | yes | `{ version = "v0.1", source = "root module default" }` | Single object supplying both version and provenance |

### Outputs

| Name | Value |
| --- | --- |
| `simple_module_with_version_from_environment_const_var` | `module_configuration` object from the environment-mapped instance |
| `simple_module_with_version_from_module_version_const_var` | `module_configuration` object from the direct-`const` instance |
| `simple_module_with_version_from_complex_environment_const_var` | `module_configuration` object from the object-attribute instance |

Each `module_configuration` is `{ module_source_info = "<...source> [vX.Y]", module_version = "vX.Y" }`.

## Variable files in this folder

There are three variable files in this configuration that _may_ provide values for the terraform configuration.

These are provided in order to show variable value precedence when providing configuration to the init, plan and apply phases.

Values struck out in the tables below are commented out in the current HEAD.

Please see the detail in [Usage](#usage) section.

| File | Loaded | Precedence | module_version | environment | complex_environment |
| --- | --- | --- | --- | --- | --- | 
| `variables.tf` | root configuration | Default values when no config provided | `v0.1` | `PROD` `(v0.1)` | `v0.1` |
| `terraform.tfvars` | automatically | Overrides variables.tf defaults | ~~`v0.1`~~ | `PROD` `(v0.1)` | `v0.1` |
| `config.auto.tfvars` | automatically (`*.auto.tfvars`) | Overrides terraform.tfvars and below | ~~`v0.2`~~ | `TEST` `(v0.2)` | ~~`v0.2`~~ |
| `../configuration/module_config.tfvars` | only with `-var-file`  | Overrides `*.auto.tfvars` and below | `v0.3` | ~~`DEV`~~ ~~`(v0.3)`~~ | ~~`v0.3`~~ |


## Usage {#usage}

No authentication is required — the child modules only create `terraform_data` resources and provide descriptive outputs.

Execute the commands below to deploy the default module configuration

```bash
cd terraform/dynamic_modules_sources_simple
terraform init
terraform apply --auto-approve
```

Inspect the outputs; each module reports its version and the source of the value of the `const` variable.

```bash
...

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

simple_module_with_version_from_complex_environment_const_var = {
  "module_source_info" = "var.complex_environment.version const from terraform.tfvars [v0.1]"
  "module_version" = "v0.1"
}
simple_module_with_version_from_environment_const_var = {
  "module_source_info" = "var.environment const from config.auto.tfvars (TEST) => [v0.2]"
  "module_version" = "v0.2"
}
simple_module_with_version_from_module_version_const_var = {
  "module_source_info" = "var.module_version const from root module default [v0.1]"
  "module_version" = "v0.1"
}
```

Inspect the outputs; each reports its version and the source of it `const` variable.

> [! NOTE]
>
> The following changes are intended to be made directly after applying the default configuration. 
>
> Re-run the commands above to reset the configuration to the default.

### Change a version by providing a .tfvars file via the CLI

Provide an additional .tfvars file containing additional `const` module source ocnfiguration

When changing const variable values that drive dynamic module sources, it is necessary to reinitialise terraform to get any updated module configuration.

> [! NOTE]
>
> All path local `terraform.tfvars` and `*.auto.tfvars` are automatically loaded, but it's necessary to provide command line arguments to specify the _same_ additional configuration files to both the init and plan/apply phases.
>
> Failure do this will result in an error identifying that a "Module source has changed"

```bash
cd terraform/dynamic_modules_sources_simple
terraform init -var-file=../configuration/module_config.tfvars
terraform apply -var-file=../configuration/module_config.tfvars --auto-approve
```

After applying the configuration with the additional .tfvars, note that one of the modules versions has changed, and that the configuration source of that change is the newly provided module_config.tfvars

```bash
...

Plan: 0 to add, 1 to change, 0 to destroy.

Changes to Outputs:
  ~ simple_module_with_version_from_module_version_const_var      = {
      ~ module_source_info = "var.module_version const from root module default [v0.1]" -> (known after apply)
      ~ module_version     = "v0.1" -> "v0.3"
    }

...

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

...

simple_module_with_version_from_module_version_const_var = {
  "module_source_info" = "var.module_version const from module_config.tfvars [v0.3]"
  "module_version" = "v0.3"
}
```

### Change a version by providing a variable value via the CLI

It is also possible to provide a value to a `const` variable using a CLI parameter.

As above it's necessary to provide the _same_ value for command line arguments to specify any additional variable values to the init and plan/apply phases.


```bash
cd terraform/dynamic_modules_sources_simple
terraform init --var complex_environment="{ version =\"v0.3\", source=\"CLI variable\" }"
terraform plan --var complex_environment="{ version =\"v0.3\", source=\"CLI variable\" }" --out var_on_cli.tfplan
terraform apply var_on_cli.tfplan
```

After applying the configuration with additional value for the variable, note that one of the modules versions has changed, and that the configuration source of that change is "CLI variable", as per the value provided.


```
...

Plan: 0 to add, 1 to change, 0 to destroy.

Changes to Outputs:
  ~ simple_module_with_version_from_complex_environment_const_var = {
      ~ module_source_info = "var.complex_environment.version const from terraform.tfvars [v0.1]" -> (known after apply)
      ~ module_version     = "v0.1" -> "v0.3"
    }

...

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

simple_module_with_version_from_complex_environment_const_var = {
  "module_source_info" = "var.complex_environment.version const from cli variable [v0.1]"
  "module_version" = "v0.1"
}

...
```

## Conclusion

`const` variables let module `source` paths be driven by configuration data.

Execution pipelines can provide module configuration alongside variable configuration, without requiring any code changes.

