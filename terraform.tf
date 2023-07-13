
terraform {
  required_version = ">=1.2.0"
  # backend "consul" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.18.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }

  }
}
