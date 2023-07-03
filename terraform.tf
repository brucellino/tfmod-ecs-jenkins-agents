
terraform {
  required_version = ">=1.2.0"
  # backend "consul" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.7.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.2.0"
    }

  }
}
