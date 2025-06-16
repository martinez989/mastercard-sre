<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.aws_lb_controller](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_lb_controller_chart_version"></a> [aws\_lb\_controller\_chart\_version](#input\_aws\_lb\_controller\_chart\_version) | The chart version of the AWS Load Balancer Controller to deploy. | `string` | `"1.7.1"` | no |
| <a name="input_aws_lb_controller_iam_role_arn"></a> [aws\_lb\_controller\_iam\_role\_arn](#input\_aws\_lb\_controller\_iam\_role\_arn) | The ARN of the IAM role for the AWS Load Balancer Controller Service Account. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the EKS cluster is deployed. | `string` | n/a | yes |
| <a name="input_cluster_autoscaler_chart_version"></a> [cluster\_autoscaler\_chart\_version](#input\_cluster\_autoscaler\_chart\_version) | The chart version of the Cluster Autoscaler to deploy. | `string` | `"9.36.0"` | no |
| <a name="input_cluster_autoscaler_iam_role_arn"></a> [cluster\_autoscaler\_iam\_role\_arn](#input\_cluster\_autoscaler\_iam\_role\_arn) | The ARN of the IAM role for the Cluster Autoscaler Service Account. | `string` | n/a | yes |
| <a name="input_eks_cluster_ca_certificate"></a> [eks\_cluster\_ca\_certificate](#input\_eks\_cluster\_ca\_certificate) | The base64 encoded certificate data for the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | The endpoint of the EKS cluster API. | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The name of the EKS cluster to connect to. | `string` | n/a | yes |
| <a name="input_enable_aws_load_balancer_controller"></a> [enable\_aws\_load\_balancer\_controller](#input\_enable\_aws\_load\_balancer\_controller) | Whether to deploy the AWS Load Balancer Controller. | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Whether to deploy the Cluster Autoscaler. | `bool` | `false` | no |
| <a name="input_enable_metrics_server"></a> [enable\_metrics\_server](#input\_enable\_metrics\_server) | Whether to deploy the Kubernetes Metrics Server. | `bool` | `false` | no |
| <a name="input_metrics_server_chart_version"></a> [metrics\_server\_chart\_version](#input\_metrics\_server\_chart\_version) | The chart version of the Metrics Server to deploy. | `string` | `"3.11.0"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->