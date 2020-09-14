variable "name" {
  default = "k8s-to-hcp-consul"
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