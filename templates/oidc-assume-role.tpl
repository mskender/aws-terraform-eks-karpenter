{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${OIDC_PRINCIPAL}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity"
    }
  ]
}