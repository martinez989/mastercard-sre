variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "node_group_instance_type" {
  type        = string
  description = "Instance type for the EKS nodes"
  default     = "t3.medium"
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