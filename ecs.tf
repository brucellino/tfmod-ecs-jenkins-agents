resource "aws_ecs_cluster" "build_agents" {
  name = "${var.cluster_name}-${var.environment}"
}

# Create task definition for basic agent
resource "aws_ecs_task_definition" "vanilla-agent" {
  family                = "ecs-vanilla-${var.environment}"
  container_definitions = file("${path.module}/task-definitions/ecs-vanilla.json")

  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]

  volume {
    name      = "deploy"
    host_path = "/mnt/efs/deploy"
  }
}
