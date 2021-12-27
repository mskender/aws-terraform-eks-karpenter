apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ${acme_clusterissuer_name}
spec:
  acme:
    email: ${acme_clusterissuer_mailaddr}
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: ${acme_clusterissuer_key}
    solvers:
    - http01:
        ingress:
          class: ${acme_clusterissuer_ingress_class}