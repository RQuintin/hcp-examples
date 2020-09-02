data "aws_vpc_peering_connection" "hcp_consul" {
  count      = var.setup_hcp ? 1 : 0
  status     = "active"
  cidr_block = var.hcp_consul_cidr_block
}

resource "aws_security_group" "allow_hcp_consul" {
  count       = var.setup_hcp ? 1 : 0
  name        = "allow-hcp-consul"
  description = "Allow HCP Consul traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Consul Server RPC"
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = [var.hcp_consul_cidr_block]
  }

  ingress {
    description = "Consul LAN Serf (tcp)"
    from_port   = 8301
    to_port     = 8301
    protocol    = "tcp"
    cidr_blocks = [var.hcp_consul_cidr_block]
  }

  ingress {
    description = "Consul LAN Serf (udp)"
    from_port   = 8301
    to_port     = 8301
    protocol    = "udp"
    cidr_blocks = [var.hcp_consul_cidr_block]
  }

  ingress {
    description     = "Consul LAN Serf (tcp) Security Groups"
    from_port       = 8301
    to_port         = 8301
    protocol        = "tcp"
    security_groups = [module.eks.cluster_primary_security_group_id, module.eks.cluster_security_group_id]
  }

  ingress {
    description     = "Consul LAN Serf (udp) Security Groups"
    from_port       = 8301
    to_port         = 8301
    protocol        = "udp"
    security_groups = [module.eks.cluster_primary_security_group_id, module.eks.cluster_security_group_id]
  }

  ingress {
    description = "Consul HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = [var.hcp_consul_cidr_block]
  }

  ingress {
    description = "Consul HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = [var.hcp_consul_cidr_block]
  }


  tags = {
    Name = "allow-hcp-consul"
  }
}

resource "aws_route" "hcp_consul" {
  count                     = var.setup_hcp ? length(module.vpc.private_route_table_ids) : 0
  route_table_id            = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block    = var.hcp_consul_cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection.hcp_consul.0.id
}

resource "local_file" "helm_values" {
  count = var.setup_hcp ? 1 : 0
  content = templatefile("helm/values.tmpl", {
    consul_host      = var.hcp_consul_host
    cluster_endpoint = module.eks.cluster_endpoint
  })
  filename = "${path.module}/values.yml"
}