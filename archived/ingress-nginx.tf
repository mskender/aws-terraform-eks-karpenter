
resource "helm_release" "ingress_nginx" {


count = var.install_ingress_nginx ? 1 : 0
name = "ingress-nginx"
repository = "https://kubernetes.github.io/ingress-nginx"
chart = "ingress-nginx"
#version = "default" #param plx
#namespace = "ingress-nginx"

set {
    name = "controller.extraArgs.enable-ssl-passthrough"
    value = "true"
}

set {
    name = "ingressClassResource"
    value = var.ingress_class
}

#add Prometheus metriks.
depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.workers,
    resource.local_file.kubeconfig
]
}