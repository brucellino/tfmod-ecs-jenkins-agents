resource "aws_security_group" "efs_mount_target" {
  name                   = "efs_mount_target_${var.environment}"
  description            = "Jenkins Agent EFS - ${var.environment}"
  vpc_id                 = data.aws_vpc.vpc.id
  revoke_rules_on_delete = true
}

resource "aws_security_group_rule" "efs_nfs" {
  type              = "ingress"
  description       = "Allow NFS traffic to the EFS mount target"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = [for s in data.aws_subnet.internal : s.cidr_block]
  security_group_id = aws_security_group.efs_mount_target.id
}

resource "aws_efs_file_system" "ecs-build-artifacts" {
  creation_token = "${var.efs_name}-${var.environment}"
  encrypted      = true
  tags = {
    Name        = var.efs_name
    Environment = var.environment
  }
}

resource "aws_efs_mount_target" "nodes" {
  file_system_id  = aws_efs_file_system.ecs-build-artifacts.id
  security_groups = [aws_security_group.efs_mount_target.id]
  for_each        = toset(data.aws_subnets.private_subnets.ids)
  subnet_id       = each.value
}
