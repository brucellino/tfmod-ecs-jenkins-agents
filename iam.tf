resource "aws_iam_role" "ecs_ingest" {
  name               = "ecs_ingest-${var.cluster_name}-${var.environment}"
  assume_role_policy = file("${path.module}/iam/assume_role.json")
}

resource "aws_iam_role_policy" "ecs_ingest" {
  name   = "ecs_instance_role-${var.environment}"
  role   = aws_iam_role.ecs_ingest.id
  policy = file("${path.module}/iam/ecs_policy.json")
}

resource "aws_iam_instance_profile" "ingest" {
  name = "ingest_profile-${var.cluster_name}-${var.environment}"
  role = aws_iam_role.ecs_ingest.name
}
