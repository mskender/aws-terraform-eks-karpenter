# EKS Karpenter module for AWS

WARNING: Still in progress, so bound to change often! Do not use this in production (yet)!


## Description

This is a simple module for creating Karpenter autoscaler deployemnt onto your EKS cluster. 
To deploy Karpemnter you'll need:

- an operational EKS cluster
- an OIDC provider in your EKS cluster
- some subnet annotations (please see Karpenter docs)
- an instance profile used for EKS K8S workers

## Examples

An example using an eks module to provision a cluster (https://github.com/mskender/aws-terraform-eks):
```
module "k8s" {
    region = "eu-west-1"
    source = "github.com/mskender/aws-terraform-eks"
    cluster_name = local.cluster_name
    eks_subnet_ids = module.network.public_subnets.*.id
    
    write_kube_config = true
    kube_config_location = local.kubeconfig_loc
    export_kube_config = false
    shellrc_file = "~/.customization"
}

module "karpenter" {
    install_karpenter = true
    source = "github.com/mskender/aws-terraform-eks-karpenter.git"

    cluster_name = "module.k8s.cluster_name"
    cluster_endpoint = module.k8s.cluster_endpoint
    oidc_url = module.k8s.cluster_oidc_url

    providers = {
        helm = helm.eks
        kubectl = kubectl.eks
    }
    instance_types = ["t3.medium"]
    subnet_name_selector = "my-k8s-public*"
    instance_profile_name = "my-k8s-eks-worker-role"
    
    ec2_tags = [
        {
            key = "Name",
            value = "${local.cluster_name}-karpenter-worker"
        }
    ]
}
```

Providers are aliased so the location of kube config file is not checked until eks cluster is created and config dumped via "k8s" module in example above:
```
provider kubectl {
    alias = "eks"
    config_path = local.kubeconfig_loc
    
}
provider helm {

    alias = "eks"
    kubernetes{
        config_path = local.kubeconfig_loc
    }
}
```




