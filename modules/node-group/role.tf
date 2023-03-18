resource aws_iam_role this {
  name = "eks-${lower(var.name)}-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource aws_iam_policy this_external_dns {
  count       = length(var.external_dns_zones) > 0 ? 1 : 0
  name        = "eks-${lower(var.name)}-external-dns-policy"
  description = "Policy external dns for ${var.cluster_name}. Managed by Terraform"

  policy = templatefile("${path.module}/templates/k8s-external-dns-r53-access.json.tmpl", { zones = var.external_dns_zones})
}

resource aws_iam_role_policy_attachment this_external_dns {
  count       = length(var.external_dns_zones) > 0 ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this_external_dns.0.arn
}

resource aws_iam_role_policy_attachment this {
  for_each    = toset(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}