terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
    }
  }
  backend "s3" {
    bucket         = "eks-state-dev" # Unique S3 bucket for dev state
    key            = "eks/dev/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "eks-state-lock-dev" # Unique DynamoDB table for dev lock
  }
}

provider "aws" {
  region = var.region
}

# Use the VPC module
module "vpc" {
  source               = "../../modules/vpc"
  name                 = "dev-eks-vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = true
  environment          = "dev"
  project_tag          = "EKS-MVP"
}

# Use the EKS Cluster module
module "eks_cluster" {
  source              = "../../modules/eks-cluster"
  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  environment         = "dev"
  project_tag         = "EKS-MVP"

  # dev-specific node group configuration
  managed_node_groups = {
    general = {
      instance_types = [var.node_group_instance_type]
      desired_size   = 1
      max_size       = 2
      min_size       = 1
      disk_size      = 20
    }
  }
}

# IAM Role for AWS Load Balancer Controller Service Account (IRSA)
resource "aws_iam_role" "aws_lb_controller_irsa" {
  name        = "dev-aws-lb-controller-irsa"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(module.eks_cluster.oidc_provider_arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/", "")}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(module.eks_cluster.oidc_provider_arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/", "")}:sub" = "system:serviceaccount:aws-lb-controller:aws-load-balancer-controller"
          }
        }
      },
    ]
  })
  tags = {
    Environment = "dev"
    Project     = "EKS-MVP"
  }
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller_irsa_attachment" {
  role       = aws_iam_role.aws_lb_controller_irsa.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLoadBalancerControllerIAMPolicy" 
}

# IAM Role for Cluster Autoscaler Service Account (IRSA)
resource "aws_iam_role" "cluster_autoscaler_irsa" {
  name        = "dev-cluster-autoscaler-irsa"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(module.eks_cluster.oidc_provider_arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/", "")}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(module.eks_cluster.oidc_provider_arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/", "")}:sub" = "system:serviceaccount:kube-system:cluster-autoscaler"
          }
        }
      },
    ]
  })
  tags = {
    Environment = "dev"
    Project     = "EKS-MVP"
  }
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name        = "dev-cluster-autoscaler-policy"
  description = "IAM policy for EKS Cluster Autoscaler in dev"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:DescribeInstances",
          "ec2:DescribeSpotInstanceRequests",
          "ec2:DescribeRegions",
          "ec2:DescribeAddresses",
          "ec2:DescribeImages",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeSubnets",
          "ec2:DescribeRouteTables",
          "ec2:DescribeVpcs",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeInstanceStatus"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler_irsa_attachment" {
  role       = aws_iam_role.cluster_autoscaler_irsa.name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn
}


module "common_add_ons" {
  source                               = "../../modules/add-ons"
  aws_region                           = var.region
  eks_cluster_name                     = module.eks_cluster.cluster_id
  eks_cluster_endpoint                 = module.eks_cluster.cluster_endpoint
  eks_cluster_ca_certificate           = module.eks_cluster.kubeconfig_certificate_authority_data
  enable_metrics_server                = true
  enable_aws_load_balancer_controller  = true
  aws_lb_controller_iam_role_arn       = aws_iam_role.aws_lb_controller_irsa.arn
  enable_cluster_autoscaler            = true
  cluster_autoscaler_iam_role_arn      = aws_iam_role.cluster_autoscaler_irsa.arn
}

data "aws_caller_identity" "current" {}