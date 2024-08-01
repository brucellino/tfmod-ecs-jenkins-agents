
terraform {
  required_version = ">=1.2.0"
  # backend "consul" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "4.3.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.4"
    }

  }
}
