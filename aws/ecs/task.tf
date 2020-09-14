resource "aws_ecs_task_definition" "consul" {
  family = "consul"
  container_definitions = templatefile("templates/task_definition.json", {
    arn_consul_secret = aws_secretsmanager_secret.hcp_consul.arn
  })
  requires_compatibilities = ["EC2"]
  task_role_arn            = aws_iam_role.ecs_task.arn
  execution_role_arn       = aws_iam_role.ecs_task.arn
  network_mode             = "awsvpc"
}

