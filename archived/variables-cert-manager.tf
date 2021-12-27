variable install_cert_manager {
    type = bool
    default = false
    description = "Whether to install Cert-Manager on EKS cluster"
}

variable cert_manager_version {
    default = "v1.6.1"
    type = string
    description = "Version of cert-manager to install"
}
variable certmanager_clusterissuer_type {
    type = string
    default = "ACME"
    description = "ClusterIssuer type to install (as per cert-manager docs)"
}


