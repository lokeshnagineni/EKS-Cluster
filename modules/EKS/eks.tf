resource aws_iam_role this {
  name               = "${var.name}-eks-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = merge(
    var.tags, {
      Name = "${var.name}-eks-role"
    }
  )
}

resource aws_iam_role_policy_attachment this {
  for_each = toset(var.aws_policy_arn_cluster)

  policy_arn = each.value
  role       = aws_iam_role.this.name
}

resource aws_eks_cluster this {
  name     = var.name
  role_arn = aws_iam_role.this.arn
  version  = var.kube_version

  vpc_config {
    security_group_ids      = var.addtl_sg_group_ids
    public_access_cidrs     = var.public_access_allowed_cidrs
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  tags = merge(
    var.tags, {
      name = var.name
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.this
  ]
}