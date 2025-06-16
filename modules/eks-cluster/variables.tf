variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster (e.g., '1.28')."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed."
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the EKS worker nodes."
  type        = list(string)
}

variable "managed_node_groups" {
  description = "A map defining the configuration for managed node groups. Key is the group name."
  type = map(object({
    instance_types = list(string)
    desired_size   = number
    max_size       = number
    min_size       = number
    disk_size      = number
    tags           = optional(map(string), {})
  }))
  default = {}
}

variable "environment" {
  description = "The environment tag (e.g., 'dev', 'test', 'prod')."
  type        = string
}

variable "project_tag" {
  description = "The project tag (e.g., 'EKS-MVP')."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to apply to the EKS cluster."
  type        = map(string)
  default     = {}
}