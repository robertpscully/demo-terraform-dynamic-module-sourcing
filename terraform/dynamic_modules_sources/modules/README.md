# modules

This folder contains versioned local modules used by the dynamic module sourcing demo.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

Each module folder represents a version of the same module interface:

- `simple_module_0.1/` — module version 0.1
- `simple_module_0.2/` — module version 0.2

Each module includes:

- `main.tf` — resource logic
- `variables.tf` — input variables
- `output.tf` — outputs
- `locals.tf` — local values or helpers

The root example selects the module version dynamically from `../locals.tf`.
