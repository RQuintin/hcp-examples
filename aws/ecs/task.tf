resource "aws_ecs_task_definition" "consul" {
  family = "consul-client"
  container_definitions = templatefile("templates/task_definition.json", {
    arn_consul_secret = aws_secretsmanager_secret.hcp_consul.arn
    ca_pem_file_path  = local.ca_pem_file_path
  })
  requires_compatibilities = ["EC2"]
  task_role_arn            = aws_iam_role.ecs_task.arn
  execution_role_arn       = aws_iam_role.ecs_task.arn
  network_mode             = "host"
}

resource "aws_ecs_service" "consul" {
  name            = "consul-client"
  cluster         = module.ecs.this_ecs_cluster_arn
  task_definition = aws_ecs_task_definition.consul.arn
  desired_count   = var.ecs_cluster_size

  placement_constraints {
    type = "distinctInstance"
  }
}