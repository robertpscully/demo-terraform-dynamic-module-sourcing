### Provide the module_version const and module_version_source variables from the same tfvars file

variable "module_version" {
  description = "The version of the module"
  type        = string
  const       = true
  default     = "v0.1"
}

variable "module_version_source" {
  description = "The source of the 'module_version' const variable"
  type        = string
  default     = "root module default"
}

### Provide the environment const and environment_source variables from the same tfvars file

variable "environment" {
  type    = string
  default = "PROD"
  const   = true
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment)
    error_message = "Invalid value for environment: ${var.environment}. Allowed values for environment are: DEV, TEST, PROD"
  }
}

variable "environment_source" {
  description = "The source of the 'environment' const variable"
  type        = string
  default     = "root module default"
}

### Single variable for complex_environment providing both version and source from a single const variable

variable "complex_environment" {
  type = object({
    version = optional(string, "v0.1")
    source  = optional(string, "root module default")
  })
  const = true
  default = {
    version = "v0.1"
    source  = "root module default"
  }
}

