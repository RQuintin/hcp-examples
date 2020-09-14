resource "aws_secretsmanager_secret" "hcp_consul" {
  name = var.name
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "hcp_consul" {
  secret_id = aws_secretsmanager_secret.hcp_consul.id
  secret_string = jsonencode({
    client_config = base64encode(templatefile("templates/client_config.json", {
      client_acl_token = file("secrets/token")
      datacenter       = var.hcp_consul_datacenter
      gossip_encrypt   = var.hcp_consul_gossip_encrypt
      host             = var.hcp_consul_host
    }))
    certificate = base64encode(file("secrets/ca.pem"))
    token       = file("secrets/token")
  })
}