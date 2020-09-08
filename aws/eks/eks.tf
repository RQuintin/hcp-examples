module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.name
  cluster_version = "1.17"
  subnets         = module.vpc.public_subnets

  tags = var.tags

  vpc_id = module.vpc.vpc_id

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    hcp_consul = {
      desired_capacity = 3
      max_capacity     = 3
      min_capacity     = 3

      instance_type   = "t2.small"
      k8s_labels      = var.tags
      additional_tags = var.additional_tags
    }
  }
}

resource "local_file" "helm_values" {
  content = templatefile("helm/values.tmpl", {
    consul_host      = var.hcp_consul_host
    cluster_endpoint = module.eks.cluster_endpoint
  })
  filename = "${path.module}/values.yml"
}