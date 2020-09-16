variable "name" {
  default = "ecs-to-hcp-consul"
}

variable "region" {
  default = "us-west-2"
}

variable "hcp_consul_cidr_block" {
  default = "172.25.16.0/20"
}

variable "hcp_consul_host" {}

variable "hcp_consul_gossip_encrypt" {}

variable "hcp_consul_datacenter" {}

variable "hcp_consul_client_acl_token" {}

variable "hcp_consul_ca_pem_file_path" {}

variable "peering_connection_has_been_added_to_hvn" {
  default = false
}

variable "kms_key_alias" {
  default = "aws/secretsmanager"
}

variable "tags" {
  default = {
    source = "hcp-consul"
  }
}