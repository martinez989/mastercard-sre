# modules/common-add-ons/variables.tf

variable "aws_region" {
  description = "The AWS region where the EKS cluster is deployed."
  type        = string
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster to connect to."
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster API."
  type        = string
}

variable "eks_cluster_ca_certificate" {
  description = "The base64 encoded certificate data for the EKS cluster."
  type        = string
}

variable "enable_metrics_server" {
  description = "Whether to deploy the Kubernetes Metrics Server."
  type        = bool
  default     = false
}

variable "metrics_server_chart_version" {
  description = "The chart version of the Metrics Server to deploy."
  type        = string
  default     = "3.11.0" # Check latest stable version
}

variable "enable_aws_load_balancer_controller" {
  description = "Whether to deploy the AWS Load Balancer Controller."
  type        = bool
  default     = false
}

variable "aws_lb_controller_chart_version" {
  description = "The chart version of the AWS Load Balancer Controller to deploy."
  type        = string
  default     = "1.7.1" # Check latest stable version
}

variable "aws_lb_controller_iam_role_arn" {
  description = "The ARN of the IAM role for the AWS Load Balancer Controller Service Account."
  type        = string
  nullable    = false # This must be provided if controller is enabled
}

variable "enable_cluster_autoscaler" {
  description = "Whether to deploy the Cluster Autoscaler."
  type        = bool
  default     = false
}

variable "cluster_autoscaler_chart_version" {
  description = "The chart version of the Cluster Autoscaler to deploy."
  type        = string
  default     = "9.36.0" # Check latest stable version
}

variable "cluster_autoscaler_iam_role_arn" {
  description = "The ARN of the IAM role for the Cluster Autoscaler Service Account."
  type        = string
  nullable    = false # This must be provided if autoscaler is enabled
}