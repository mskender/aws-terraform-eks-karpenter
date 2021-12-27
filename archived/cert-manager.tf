locals {
    
    clusterissuer_manifest = templatefile("${path.module}/templates/acme-clusterissuer.tpl" ,
    {
        acme_clusterissuer_name = "le-prod"
        acme_clusterissuer_mailaddr = "admin@test.com"
        acme_clusterissuer_key = "le-prod-pk1"
        acme_clusterissuer_ingress_class = var.ingress_class

    })

}


resource "helm_release" "cert_manager" {

provider = helm.eks
count = var.install_cert_manager ? 1 : 0
name = "cert-manager"
repository = "https://charts.jetstack.io"
chart = "cert-manager"
#version = "default" #param plx

set {
    name = "installCRDs"
    value = "true"
}

set {
    name = "create-namespace"
    value = "true" 
}
set {
    name = "version"
    value = "v1.6.1"
}

set {
    name = "prometheus.enabled"
    value = "false"
}

set {
    name = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
}

depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.workers,
    resource.local_file.kubeconfig
]
}


resource "kubernetes_manifest" "clusterissuer" {
    count = var.install_cert_manager ? 1 : 0
    manifest = yamldecode(local.clusterissuer_manifest)

    depends_on = [
      helm_release.cert_manager
    ]
} 