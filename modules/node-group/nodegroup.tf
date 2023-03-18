resource aws_eks_node_group this {
  cluster_name    = var.cluster_name
  node_group_name = var.name
  node_role_arn   = aws_iam_role.this.arn
  subnet_ids      = var.subnet_ids
  ami_type        = var.ami_type
  disk_size       = var.node_disk_size
  labels          = var.node_labels
  instance_types  = var.node_instance_types

  force_update_version = true

  dynamic "launch_template" {
    for_each = var.launch_template
    content {
      id     = launch_template.key
      version = launch_template.value
    }
  }

  dynamic "remote_access" {
    for_each = var.remote_access
    content {
      ec2_ssh_key               = remote_access.key
      source_security_group_ids = remote_access.value
    }
  }

  scaling_config {
    min_size     = var.scaling_config.min_size
    max_size     = var.scaling_config.max_size

    desired_size = var.scaling_config.min_size
  }

  tags = merge(
    var.tags, {
      name = "${var.cluster_name}-node"
    }
  )

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size,
    ]
  }
}
