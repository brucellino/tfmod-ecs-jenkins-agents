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
    values = ["prod"]
  }

  filter {
    name   = "tag:Name"
    values = ["infra-eu-central-1"]
  }
}

# Get subnets tagged internal
data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Scope = "internal"
  }
}

data "aws_subnet" "internal" {
  for_each = data.aws_subnet_ids.private_subnet_ids.ids
  id       = each.value
}

# internal subnet in euc1b
data "aws_subnet" "internal_b" {
  state             = "available"
  availability_zone = "eu-central-1b"
  filter {
    name   = "tag:Scope"
    values = ["internal"]
  }
}

# internal subnet in euc1a
data "aws_subnet" "internal_a" {
  state             = "available"
  availability_zone = "eu-central-1a"
  filter {
    name   = "tag:Scope"
    values = ["internal"]
  }
}
