locals {
  ca_pem_file_path = "/tmp/ca.pem"
}

resource "aws_secretsmanager_secret" "hcp_consul" {
  name = var.name
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "hcp_consul" {
  secret_id = aws_secretsmanager_secret.hcp_consul.id
  secret_string = jsonencode({
    client_config = base64encode(templatefile("templates/client_config.json", {
      client_acl_token = var.hcp_consul_client_acl_token
      datacenter       = var.hcp_consul_datacenter
      gossip_encrypt   = var.hcp_consul_gossip_encrypt
      host             = var.hcp_consul_host
      ca_pem_file_path = local.ca_pem_file_path
    }))
    certificate = base64encode(file(var.hcp_consul_ca_pem_file_path))
    token       = var.hcp_consul_client_acl_token
  })
}