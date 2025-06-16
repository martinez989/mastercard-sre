output "cluster_id" {
  description = "The ID of the EKS cluster."
  value       = module.eks.cluster_id
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster."
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster's Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "kubeconfig_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with your cluster."
  value       = module.eks.cluster_certificate_authority_data
}

output "oidc_provider_arn" {
  description = "The ARN of the IAM OIDC provider for the cluster."
  value       = module.eks.oidc_provider_arn
}

output "cluster_security_group_id" {
  description = "The ID of the EKS cluster security group."
  value       = module.eks.cluster_security_group_id
}

output "worker_security_group_id" {
  description = "The ID of the EKS worker nodes security group."
  value       = module.eks.node_security_group_id
}