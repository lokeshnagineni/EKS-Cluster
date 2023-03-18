variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "Main_Routing_Table" {}
variable "azs" {}
variable "private_Routing_Table" {}
variable "environment" {}
variable "natgw_subnet_suffix" {}
variable "name" {
    type = string
}