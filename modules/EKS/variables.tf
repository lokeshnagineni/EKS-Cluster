variable "aws_region" {
  description = "AWS Region to use"
  default     = "us-east-1"
}

variable "name" {
  description = "The name of the EKS cluster"
  default     = ""
}

variable "addtl_sg_group_ids" {
  description = "The list of additional security group IDs to attach for cross-account elastic network"
  default     = []
}

variable "kube_version" {
  description = "The Kubernetes version of the EKS cluster to launch"
  default     = ""
}

variable "endpoint_public_access" {
  default = false
}

variable "endpoint_private_access" {
  default = true
}

variable "subnet_ids" {
  description = "List of subnet IDs. Must be in at least two different availability zones"
  default     = []
}

variable "public_access_allowed_cidrs" {
  description = "List of cidr blocks allowed to access the public endpoint"
  default     = ["0.0.0.0/0"]
}

variable "aws_policy_arn_cluster" {
  description = ""
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}

variable "tags" {
  description = "Extra tags"
  default = {}
}