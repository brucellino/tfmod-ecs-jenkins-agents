terraform {
  backend "consul" {
    path = "acg/test/tfmod-ecs-agents"
  }
}

variable "aws_backend_path" {
  description = "Path on Vault for the AWS credentials"
  default     = "acg"
}

variable "aws_role_name" {
  type        = string
  description = "Name of the AWS policy to associate with the crednetials"
  default     = "full-access"
}

variable "aws_region" {
  type        = string
  description = "Name of the AWS region to use"
  default     = "us-east-1"
}
provider "vault" {

}

data "vault_aws_access_credentials" "creds" {
  backend = var.aws_backend_path
  role    = var.aws_role_name
}

provider "aws" {
  region     = var.aws_region
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
}

module "ecs_agents" {
  source        = "../../"
  cluster_name  = "test"
  efs_name      = "test"
  environment   = "nonprod"
  owner_account = "brucellino"
}
