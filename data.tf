data "aws_region" "current" {}
data "aws_ami" "ecs_ami" {
  owners      = ["amazon"]
  name_regex  = "^.*ecs.*-2.*"
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "vpc" {
  default = false
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }

  filter {
    name   = "tag:Name"
    values = ["infra-${data.aws_region.current.name}"]
  }
}

# Get subnets tagged internal
data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  tags = {
    # Name  = "internal"
    Scope = "internal"
  }
}
data "aws_subnet" "internal" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
}
