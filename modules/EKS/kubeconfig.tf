data aws_caller_identity this {}

data aws_arn this {
  arn = data.aws_caller_identity.this.arn
}

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.this.endpoint}
    certificate-authority-data: ${aws_eks_cluster.this.certificate_authority.0.data}
  name: ${aws_eks_cluster.this.name}
contexts:
- context:
    cluster: ${aws_eks_cluster.this.name}
    user: ${aws_eks_cluster.this.name}
  name: ${aws_eks_cluster.this.name}
current-context: ${aws_eks_cluster.this.name}
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.this.name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws
      args:
        - "eks"
        - "get-token"
        - "--cluster-name"
        - "${aws_eks_cluster.this.name}"
        - "--region"
        - "${var.aws_region}"
%{ if data.aws_arn.this.service == "sts" ~}
        - --role
        - "arn:aws:iam::${data.aws_arn.this.account}:role/${split("/", data.aws_arn.this.resource)[1]}"
%{ endif ~}
KUBECONFIG
}