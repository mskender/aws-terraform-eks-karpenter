locals {
    
    karpenter_provisioner_manifest = templatefile("${path.module}/templates/karpenter-provisioner.tpl" ,
    {
        provisioner_name = "karpenter-default-provisioner"
        instance_profile = var.instance_profile_name
        subnet_name_selector = var.subnet_name_selector
        subnet_tag_selector = var.subnet_tag_selector
        launch_template_name = var.launch_template_name
        ec2_tags = var.ec2_tags 
        instance_types = join(",",var.instance_types)
        capacity_types = join(",",var.capacity_types)
        arch = var.arch
        ttl_after_empty = var.ttl_after_empty
    })

}

resource "helm_release" "karpenter" {
  
  count = var.install_karpenter ? 1:0
  
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = "0.5.3"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter_sa_role[0].arn
  }

  set {
    name  = "controller.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "controller.clusterEndpoint"
    value = var.cluster_endpoint
  }
}


resource "kubectl_manifest" "karpenter_provider" {
    count = var.install_karpenter ? 1 : 0
    yaml_body = local.karpenter_provisioner_manifest

    depends_on = [
      helm_release.karpenter
    ]
} 