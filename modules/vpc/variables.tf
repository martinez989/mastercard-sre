variable "name" {
  description = "Name prefix for VPC resources (e.g., 'dev-eks-vpc')."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT Gateways for private subnets."
  type        = bool
  default     = true
}

variable "environment" {
  description = "The environment tag (e.g., 'dev', 'test', 'prod')."
  type        = string
}

variable "project_tag" {
  description = "The project tag (e.g., 'EKS-MVP')."
  type        = string
}