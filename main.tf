provider "aws" {
    access_key = "AKIASFFWUMYDEG2BQNO7"
    secret_key = "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"
    region = "us-east-1"
}

module testenv {
  source = "./modules/network"
vpc_cidr = "10.120.0.0/16"
vpc_name = "testenv-vpc"
IGW_name = "testenv-vpc-igw"
key_name = "ekskeypair"
azs = ["us-east-1a","us-east-1b","us-east-1c"] 
public_subnets = ["10.120.1.0/24","10.120.2.0/24","10.120.3.0/24"]
private_subnets = ["10.120.10.0/24","10.120.20.0/24","10.120.30.0/24"]
Main_Routing_Table  = "Main_Routing_Table"
private_Routing_Table = "private_Routing_Table"
environment = "prod"
natgw_subnet_suffix = "natgw"
name = "main"
}
