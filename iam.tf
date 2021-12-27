locals {
  karpenter_assume_role = templatefile("${path.module}/templates/oidc-assume-role.tpl",
    {
      OIDC_PRINCIPAL = "arn:aws:iam::${local.account_id}:oidc-provider/${var.oidc_url}",
      OIDC_URL       = var.oidc_url
      SA             = "system:serviceaccount:karpenter:karpenter"
    }
  )
}

resource "aws_iam_policy" "karpenter_contoller" {

  count = var.install_karpenter ? 1 : 0

  name = "karpenter-policy-${var.cluster_name}"


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateLaunchTemplate",
          "ec2:CreateFleet",
          "ec2:RunInstances",
          "ec2:CreateTags",
          "iam:PassRole",
          "ec2:TerminateInstances",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeAvailabilityZones",
          "ssm:GetParameter"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "karpenter_sa_role" {

  count              = var.install_karpenter ? 1 : 0
  name               = "karpeneter-role"
  assume_role_policy = local.karpenter_assume_role
}

resource "aws_iam_role_policy_attachment" "karpenter_sa_attachment" {

  count      = var.install_karpenter ? 1 : 0
  role       = aws_iam_role.karpenter_sa_role[0].name
  policy_arn = aws_iam_policy.karpenter_contoller[0].arn
}