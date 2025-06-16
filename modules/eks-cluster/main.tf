module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.0" 

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnet_ids 

  authentication_mode = "API_AND_CONFIG_MAP" 

  cluster_endpoint_public_access  = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] # NOT for production!

  eks_managed_node_groups = var.managed_node_groups

  cluster_addons = {
    coredns = {
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    kube-proxy = {
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    vpc-cni = {
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
  }
  
  tags = merge(
    {
      Name        = var.cluster_name
      Environment = var.environment
      Project     = var.project_tag
    },
    var.additional_tags
  )
}
