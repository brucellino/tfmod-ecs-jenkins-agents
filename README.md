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
