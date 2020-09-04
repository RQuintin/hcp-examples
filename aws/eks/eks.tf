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

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# In case of not creating the cluster, this will be an incompletely configured, unused provider, which poses no problem.
provider "kubernetes" {
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, list("")), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, list("")), 0))
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, list("")), 0)
  load_config_file       = false
  version                = "1.10"
}


resource "local_file" "helm_values" {
  content = templatefile("helm/values.tmpl", {
    consul_host      = var.hcp_consul_host
    cluster_endpoint = module.eks.cluster_endpoint
  })
  filename = "${path.module}/values.yml"
}