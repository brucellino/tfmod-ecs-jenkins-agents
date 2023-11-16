
terraform {
  required_version = ">=1.2.0"
  # backend "consul" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.23.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }

  }
}
