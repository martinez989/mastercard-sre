variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "core_dns_version" {
  type        = number
  description = "Instance type for the EKS nodes"
  default     = "v1.11.1-eksbuild.6"
}

variable "environment" {
  type        = string
  description = "Name of the EKS node group"
  default     = "dev"
}

variable "kube_proxy_version" {
  type        = string
  description = "Instance type for the EKS nodes"
  default     = "v1.29.1-eksbuild.2"
}

variable "node_group_desired_capacity" {
  type        = number
  description = "Instance type for the EKS nodes"
  default     = 3
}

variable "node_group_instance_type" {
  type        = string
  description = "Instance type for the EKS nodes"
  default     = "t3.medium"
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS node group"
  default     = "dev-node-group"
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "region" {
  type        = string
  description = "Instance type for the EKS nodes"
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_cni_version" {
  type        = string
  description = "Instance type for the EKS nodes"
  default     = "v1.17.1-eksbuild.1"
}