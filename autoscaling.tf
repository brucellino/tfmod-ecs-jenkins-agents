data "http" "gh_key" {
  url = "https://github.com/${var.owner_account}.keys"
}
resource "aws_key_pair" "agent" {
  key_name   = "jenkins-key"
  public_key = data.http.gh_key.body
}

resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  description       = "Allow incoming ssh from Tailscale VPN"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["100.86.56.85/32"]
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group_rule" "ssh_egress" {

  description       = "Allow all outgoing traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.ssh.id
}
# resource "aws_launch_configuration" "ecs_cluster" {
#   name                 = "Jenkins ECS ${var.cluster_name} ${var.environment}"
#   iam_instance_profile = aws_iam_instance_profile.ingest.name
#   enable_monitoring    = true
#   image_id             = data.aws_ami.ecs_ami.id

#   lifecycle {
#     create_before_destroy = true
#   }

#   security_groups = [
#     aws_security_group.efs_mount_target.id,
#     aws_security_group.ssh.id
#   ]
#   # // security_groups             = []
#   instance_type               = var.jenkins_agent_instance_type
#   associate_public_ip_address = false
#   key_name                    = aws_key_pair.agent.key_name
#   root_block_device {
#     encrypted             = true
#     volume_type           = "gp3"
#     volume_size           = 100
#     delete_on_termination = true
#   }
#   user_data  = <<EOF
# #!/bin/bash
# mkdir /mnt/efs
# yum install -y amazon-efs-utils
# mount -t efs ${aws_efs_file_system.ecs-build-artifacts.id}:/ /mnt/efs
# echo ECS_CLUSTER=${aws_ecs_cluster.build_agents.name} >> /etc/ecs/ecs.config
# mount -l
# touch /mnt/efs/${timestamp()}
# docker pull mongo:3.4-jessie
# docker pull rabbitmq:latest
# docker pull redis:latest
# docker pull dwmkerr/dynamodb
# docker pull mariadb:10.2
# docker pull elasticsearch:5
# df -h
# EOF
#   depends_on = [aws_efs_mount_target.nodes]
# }

# resource "aws_autoscaling_group" "ecs_nodes" {
#   name     = aws_launch_configuration.ecs_cluster.name
#   min_size = 2

#   # Docs suggest remoting "desired capacity"
#   # https://www.terraform.io/docs/providers/aws/r/autoscaling_policy.html
#   desired_capacity = 2
#   max_size         = 20

#   health_check_type    = "EC2"
#   vpc_zone_identifier  = toset(data.aws_subnets.private_subnets.ids)
#   launch_configuration = aws_launch_configuration.ecs_cluster.name

#   protect_from_scale_in = true
# }

# resource "aws_autoscaling_policy" "cpu-policy" {
#   name                   = "cpu-policy"
#   autoscaling_group_name = aws_autoscaling_group.ecs_nodes.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "1"

#   # cooldown: no utilization can happen!!!
#   cooldown    = "300"
#   policy_type = "SimpleScaling"
# }

# resource "aws_autoscaling_policy" "cpu-policy-down" {
#   name                   = "cpu-policy-down"
#   autoscaling_group_name = aws_autoscaling_group.ecs_nodes.name
#   adjustment_type        = "ChangeInCapacity"
#   scaling_adjustment     = "-1"

#   # cooldown: no utilization can happen!!!
#   cooldown    = "300"
#   policy_type = "SimpleScaling"
# }

# resource "aws_cloudwatch_metric_alarm" "reservation-alarm" {
#   alarm_name          = "cpu-reservations"
#   alarm_description   = "CPU reservations full"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUReservation"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Maximum"
#   threshold           = "20"

#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.ecs_nodes.name
#   }

#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.cpu-policy.arn]
# }

# resource "aws_cloudwatch_metric_alarm" "cpu-alarm" {
#   alarm_name          = "cpu-alarm"
#   alarm_description   = "CPU Utilisation above threshold"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "90"

#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.ecs_nodes.name
#   }

#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.cpu-policy.arn]
# }

# resource "aws_cloudwatch_metric_alarm" "cpu-scaledown" {
#   alarm_name          = "cpu-scaledown"
#   alarm_description   = "Scale down due to low CPU utilisation"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "20"

#   dimensions = {
#     "AutoScalingGroupName" = aws_autoscaling_group.ecs_nodes.name
#   }

#   actions_enabled = true
#   alarm_actions   = [aws_autoscaling_policy.cpu-policy-down.arn]
# }
