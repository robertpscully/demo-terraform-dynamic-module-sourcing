terraform {
  required_version = ">= 1.15"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.80"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "tfe" {}