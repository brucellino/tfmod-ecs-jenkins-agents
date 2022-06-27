variable "environment" {
  description = "Environment we deploy into (nonprod/prod)"
  type        = string
  validation {
    condition     = can(regex("(nonprod|prod)", var.environment))
    error_message = "Environment must be either nonprod or prod."
  }
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string

  validation {
    condition     = can(regexall("[\\w+=,.@-]", var.cluster_name))
    error_message = "Error: invalid value for name (must match [word+=,.@-])."
  }
}

variable "jenkins_agent_instance_type" {
  description = "Instance type of the Jenkins agent cluster. Choose a type with a single CPU (2vCPUs) per instance, to make packing efficient."
  default     = "t3.medium"
}

variable "efs_name" {
  description = "Name of the EFS used in this environment"
  type        = string

  validation {
    condition     = can(regex("^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-@]*)$", var.efs_name))
    error_message = "Invalid EFS name."
  }
}

variable "owner_account" {
  description = "Github account of the owner of the service. We need this to get the ssh key"
  type        = string
}

output "subnets" {
  value = data.aws_subnets.private_subnets
}
