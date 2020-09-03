variable "name" {
  default = "k8s-to-hcp-consul"
}

variable "region" {
  default = "us-east-1"
}

variable "hcp_consul_cidr_block" {
  default = "172.25.16.0/20"
}

variable "hcp_consul_host" {}

variable "peering_connection_has_been_added_to_hvn" {
  default = true
}