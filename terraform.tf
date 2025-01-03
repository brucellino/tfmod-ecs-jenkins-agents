
terraform {
  required_version = ">=1.2.0"
  # backend "consul" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }

  }
}
