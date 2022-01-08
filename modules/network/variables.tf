//-------------------------------------------------------------
//   AWS DEFAULT VARIABLES
//-------------------------------------------------------------
variable "aws_account_id" {
  description = "The AWS Account id"
  type=string
}
variable "aws_azs" {
  type = list(any)
}
variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "af-south-1"
  type=string
}
//-------------------------------------------------------------
//   NETWORK VARIABLES
//-------------------------------------------------------------
variable "vpc_cidr_block" {
  description = "VPC cider block"
  default = "172.16.0.0/16"
  type=string
}

variable "subnet_cidr_block" {
  description = "subnet cider block"
  default = "172.16.10.0/24"
  type=string
}

variable "network_interface_private_ips" {
  description = "network interface private ip"
  type=list(string) //["172.16.10.100"]
}