variable install_ingress_nginx {
    type = bool
    default = false
    description = "Whether to install Nginx Ingress on EKS cluster. Helm release from https://github.com/kubernetes/ingress-nginx"
}

variable ingress_class {
    description = "Nginx class is a particular ingress controller identifier. Defaults to nginx."
    type = string
    default = "nginx"
}