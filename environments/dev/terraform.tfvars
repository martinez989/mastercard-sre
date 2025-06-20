cluster_name    = "dev-cluster"
region          = "eu-central-1"
cluster_version = "1.32"
environment     = "dev"

vpc_cni_version    = "v1.17.1-eksbuild.1"
core_dns_version   = "v1.11.1-eksbuild.6"
kube_proxy_version = "v1.29.1-eksbuild.2"

node_group_instance_type    = "t3.medium"
node_group_desired_capacity = 3