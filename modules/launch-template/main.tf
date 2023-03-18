resource aws_launch_template this {
  name_prefix = "${var.name}-"
  description = var.description

  ebs_optimized = var.ebs_optimized
  image_id      = var.image_id
  user_data     = base64encode(var.user_data)
  key_name      = var.keypair
  instance_type = var.instance_type

  vpc_security_group_ids  = var.security_group_ids
  update_default_version  = true
  disable_api_termination = var.termination_protection

  instance_initiated_shutdown_behavior = var.shutdown_behavior

  dynamic "iam_instance_profile" {
    for_each = var.instance_profile == null ? {} : {"profile" = var.instance_profile}
    content {
      name = iam_instance_profile.value
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 2
  }

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings

    content {
      device_name  = "/dev/${block_device_mappings.key}"
      ebs {
          encrypted   = true
          kms_key_id  = block_device_mappings.value.kms_key_arn
          iops        = block_device_mappings.value.iops
          volume_size = block_device_mappings.value.volume_size
          volume_type = block_device_mappings.value.volume_type

          delete_on_termination = true
      }
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags, {
        Name = var.name
      }
    )
  }

  tags = merge(
    var.tags, {
      Name = var.name
    }
  )  
}