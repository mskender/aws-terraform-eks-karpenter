# EKS Karpenter module for AWS

WARNING: Still in progress, so bound to change often! Do not use this in production!

## Description

This is a simple module for creating Karpenter autoscaler deployemnt onto your EKS cluster,

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.38.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.karpenter_contoller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.karpenter_sa_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.karpenter_sa_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.karpenter_provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arch"></a> [arch](#input\_arch) | Architecture. amd64 or arm. | `string` | `"amd64"` | no |
| <a name="input_capacity_types"></a> [capacity\_types](#input\_capacity\_types) | Capacity type - on-demand, spot, or both. | `list(string)` | <pre>[<br>  "on-demand"<br>]</pre> | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | EKS cluster endpoint. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name. | `string` | n/a | yes |
| <a name="input_ec2_tags"></a> [ec2\_tags](#input\_ec2\_tags) | key/value pair list of tags to apply to launched EC2 worker nodes. | <pre>list(object({<br>        key = string<br>        value = string<br>    }))</pre> | `null` | no |
| <a name="input_install_karpenter"></a> [install\_karpenter](#input\_install\_karpenter) | Whether to install Karpenter autoscaler for EKS. | `bool` | `false` | no |
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | IAM instance profile name to assign to autoscaled worker nodes. Mandatory. | `string` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Instance types available to deployment as worker nodes. | `list(string)` | <pre>[<br>  "t3.medium",<br>  "t3.large",<br>  "t3.xlarge"<br>]</pre> | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Launch template to use when spawning worker nodes. | `string` | `null` | no |
| <a name="input_oidc_url"></a> [oidc\_url](#input\_oidc\_url) | OIDC url of the EKS cluster. Needed for Karpenter ServiceAccount. | `string` | n/a | yes |
| <a name="input_subnet_name_selector"></a> [subnet\_name\_selector](#input\_subnet\_name\_selector) | String to match subnet names to place Karpenter autoscaling nodes. Won't be used if not specified. | `string` | `null` | no |
| <a name="input_subnet_tag_selector"></a> [subnet\_tag\_selector](#input\_subnet\_tag\_selector) | key/value pair list pass to provisioner to filter the subnets. | <pre>list(object({<br>        key = string<br>        value = string<br>    }))</pre> | `null` | no |
| <a name="input_ttl_after_empty"></a> [ttl\_after\_empty](#input\_ttl\_after\_empty) | TTL of the node after no load is running on it. | `number` | `30` | no |

## Outputs

No outputs.
