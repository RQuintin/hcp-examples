resource "aws_secretsmanager_secret" "hcp_consul" {
  name = var.name
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "hcp_consul" {
  secret_id = aws_secretsmanager_secret.hcp_consul.id
  secret_string = jsonencode({
    client_config = file("secrets/client_config.json")
    certificate   = file("secrets/ca.pem")
    token         = file("secrets/token")
  })
}