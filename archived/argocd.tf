resource "helm_release" "argocd" {

#https://github.com/bitnami/charts/tree/master/bitnami/argo-cd/#installing-the-chart
count = var.install_argocd ? 1 : 0
name = "argo-cd"
repository = "https://charts.bitnami.com/bitnami"
chart = "argo-cd"
version = "2.0.19"
namespace = "argo-cd"
create_namespace = true
cleanup_on_fail = true
# set {
#     name = "global.imageRegistry"
#     value = ""
# }



# set {
#     name = "global.imagePullSecrets"
#     value = "[]" 
# }
set {
    name = "server.ingress.enabled"
    value = var.install_ingress_nginx
}
set {
    name = "server.ingress.hostname"
    value = var.argocd_fqdn
}

set {
    name = "server.ingress.tls"
    value = "true"
}
set {
    name = "server.ingress.annotations"
    value = yamlencode({
        "cert-manager.io/cluster-issuer" =  "le-prod"
        "kubernetes.io/ingress.class": "nginx"
        "kubernetes.io/tls-acme": "true"
        "nginx.ingress.kubernetes.io/ssl-passthrough": "true"
    })
}


depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.workers,
    resource.local_file.kubeconfig
]
}