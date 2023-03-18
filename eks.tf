module eks_cluster {
  source = "./modules/EKS"

  aws_region              = "us-east-1"
  kube_version            = "1.24"
  name                    = "eks-test"
  addtl_sg_group_ids      = [module.testenv.sgid]
  endpoint_private_access = true
  endpoint_public_access  = true
  subnet_ids = concat(
    module.testenv.all_public_subnets,
    module.testenv.all_private_subnets
  )

  tags = {
    "eks:cluster" = "eks-test"
    "test:environment" = "prod"
  }
}

data tls_certificate eks_tls {
  url = module.eks_cluster.oidc_provider_url
}

resource aws_iam_openid_connect_provider eks_oidc_provider {
  url = module.eks_cluster.oidc_provider_url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_tls.certificates[0].sha1_fingerprint]
}    
