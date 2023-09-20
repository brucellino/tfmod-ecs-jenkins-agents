
terraform {
  required_version = ">=1.2.0"
  # backend "consul" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.20.1"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }

  }
}
