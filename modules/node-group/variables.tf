variable managed_policy_arns {
  description = "List of Amazon-managed policies to apply to the node group"
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
}

variable cluster_name {
  description = "The name of the EKS cluster this node group is associated with"
  default     = ""
}

variable name {
  description = "The name of the node group"
  default     = ""
}

variable node_iam_role_arn {
  description = "The ARN of the IAM role to attach to node group"
  default     = ""
}

variable subnet_ids {
  description = "List of Subnet IDs to assciate this node group"
  type        = list(string)
  default     = []
}

variable node_disk_size {
  description = "The size of the root volume/disk in GBs"
  type        = number
  default     = null
}

variable ami_type {
  description = "EKS nodegroup AMI type x86, x86 accelerated, arm"
  default = "AL2_x86_64"
}

variable node_instance_types {
  description = "The types of the instance"
  type        = list(string)
  default     = []
}

variable launch_template {
  description = "Map of template id and version. Must contain only one element"
  type    = map
  default = {}

  validation {
    condition     = length(var.launch_template) < 2
    error_message = "Can have atmost one key."
  }
}

variable remote_access {
  description = "Map of ssh-keypair and list of SG ids to give access to nodes"
  type    = map
  default = {}

  validation {
    condition     = length(var.remote_access) < 2
    error_message = "Can have atmost one key."
  }
}

variable scaling_config {
  description = "The scaling configuration"

  type = object({
    min_size     = number,
    max_size     = number
  })

  default = {
    min_size = 1,
    max_size = 1
  }
}

variable node_labels {
  description = "extra node group labels"
  type    = map(string)
  default = {}
}

variable external_dns_zones {
  description = "Zone IDs that external dns can access"
  type        = list
  default     = []
}

variable tags {
  description = "Extra resource tags"
  default = {}
}