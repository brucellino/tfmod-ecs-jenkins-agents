resource "aws_ecs_cluster" "build_agents" {
  name = "${var.cluster_name}-${var.environment}"

}

# Create task definition for basic agent
resource "aws_ecs_task_definition" "vanilla-agent" {
  family                   = "ecs-vanilla-${var.environment}"
  container_definitions    = file("${path.module}/task-definitions/ecs-vanilla.json")
  cpu                      = 512
  memory                   = 1024
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  volume {
    name = "deploy"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.ecs-build-artifacts.id
      root_directory = "/mnt/efs/deploy"
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name = aws_ecs_cluster.build_agents.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
