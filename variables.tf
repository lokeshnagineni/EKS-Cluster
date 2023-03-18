variable environment {
  type    = string
  default = "prod"

  validation {
    condition     = can(regex("^(prod|staging|test)$", var.environment))
    error_message = "The environment value must be any of the following (staging|prod|test)."
  }
}

# variable vpc_config {
#   # for some reason i can't make object({vpc_id=string ...}) work
#   description = "The VPC object output from modules/vpc"
#   type        = any
# }

variable cluster_name {
  type    = string
  default = "test"
}

variable kubernetes_version {
  type    = string
  default = "1.24"
}

variable region {
  type    = string
  default = "us-east-1"
}

variable ebs_kms_key {}

variable bastion_role {
  description = "Role for bastion access"
  default     = ""
}

variable natgw_subnet_suffix {
  description = "Suffix to append to private subnets name"
  default     = "natgw"
}