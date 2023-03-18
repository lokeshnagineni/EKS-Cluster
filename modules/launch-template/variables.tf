variable name {
  description = "Name of the launch template"
}

variable environment {
  default = "test"
}

variable owner {
  default = "gengo"
}

variable description {
  description = "Launch template description"
  default = "Managed by Terraform"
}

variable ebs_optimized {
  default = false
}

variable image_id {
  description = "AMI ID for instance"
  default = null
}

variable user_data {
  default = ""
}

variable keypair {
  description = "key pair name"
  default = "eks-nodegroup"
}

variable instance_type {
  default = "t2.micro"
}

variable security_group_ids {
  description = "List of security groups IDs"
  default = []
}

variable termination_protection {
  default = false
}

variable shutdown_behavior {
  description = "Shutdown behavior for the instance. Can be stop or terminate"
  default = null
}

variable instance_profile {
  default = null
}

variable block_device_mappings {
  description = "List of block device mappings"
  type = map(object({
    kms_key_arn           = string
    volume_size           = number
    volume_type           = string
    iops                  = number
  }))
  default = {}
}

variable tags {
  description = "Extra tags"
  type = map
  default = {}
}