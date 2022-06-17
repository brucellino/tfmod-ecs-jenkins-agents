# Jenkins ECS Terraform module

Terraform module for a Jenkins agent deployment in ECS.

## Variables

- `ecs_ami_id`: AMI of the EC2 instance we will deploy into the ECS cluster
- `launch_config_sg`: Security group to apply to the launch configuration
- `jenkins_agent_instance_type`: The agent instance type that the Jenkins instance will be launched with
- `efs_mount_target_subnet`: EFS mount target subnet
- `efs_mount_target_sg`: EFS mount target security group

## Data

The following data is discovered and used in application of the plan:

- Subnets
- IAM role
- ECS AMI
- security groups

## Resources

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.ecs_nodes](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.cpu-policy](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.cpu-policy-down](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.cpu-alarm](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu-scaledown](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.reservation-alarm](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecs_cluster.build_agents](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_task_definition.vanilla-agent](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/ecs_task_definition) | resource |
| [aws_efs_file_system.ecs-build-artifacts](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.nodes](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/efs_mount_target) | resource |
| [aws_iam_instance_profile.ingest](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ecs_ingest](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_ingest](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/iam_role_policy) | resource |
| [aws_launch_configuration.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/launch_configuration) | resource |
| [aws_security_group.efs_mount_target](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.efs_nfs](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/resources/security_group_rule) | resource |
| [aws_ami.ecs_ami](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/data-sources/ami) | data source |
| [aws_subnet.internal](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/data-sources/subnet) | data source |
| [aws_subnet.internal_a](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/data-sources/subnet) | data source |
| [aws_subnet.internal_b](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/data-sources/subnet) | data source |
| [aws_subnet_ids.private_subnet_ids](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/4.19.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the ECS cluster | `string` | n/a | yes |
| <a name="input_efs_name"></a> [efs\_name](#input\_efs\_name) | Name of the EFS used in this environment | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment we deploy into (nonprod/prod) | `string` | n/a | yes |
| <a name="input_jenkins_agent_instance_type"></a> [jenkins\_agent\_instance\_type](#input\_jenkins\_agent\_instance\_type) | Instance type of the Jenkins agent cluster. Choose a type with a single CPU (2vCPUs) per instance, to make packing efficient. | `string` | `"t3.medium"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
<!-- END_TF_DOCS -->
