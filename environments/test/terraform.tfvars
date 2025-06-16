cluster_name = "test-cluster"
region       = "eu-central-1"
cluster_version = "1.32"
environment = "test"

vpc_cni_version = "v1.17.1-eksbuild.1"
core_dns_version = "v1.11.1-eksbuild.6"
kube_proxy_version = "v1.29.1-eksbuild.2"

node_group_instance_type = "t3.medium"
node_group_desired_capacity = 3

vpc_cidr_block       = "10.50.0.0/16"
public_subnet_cidrs  = ["10.50.1.0/24", "10.50.2.0/24"]
private_subnet_cidrs = ["10.50.101.0/24", "10.50.102.0/24"]