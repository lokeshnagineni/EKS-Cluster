output "kube_version" {
  value = aws_eks_cluster.this.version
}

output "cert_auth" {
  value = aws_eks_cluster.this.certificate_authority.0.data
}

output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "arn" {
  value = aws_eks_cluster.this.arn
}

output "name" {
  value = aws_eks_cluster.this.name
}

output "sg_id" {
  value = aws_eks_cluster.this.vpc_config.0.cluster_security_group_id
}

output oidc_provider_url {
  value = aws_eks_cluster.this.identity.0.oidc.0.issuer
}