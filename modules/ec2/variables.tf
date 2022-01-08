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
//   ECS VARIABLES
//-------------------------------------------------------------
variable "ami" {
  description = "ami value for ec2"
  default = "ami-030b8d2037063bab3"
  type=string
}
variable "instance_type" {
  description = "ec2 instance type"
  default = "t2.micro"
  type=string
}
variable "aws_network_interface_id" {
  description = "ID of network interface"
  type=string
}
variable "device_index" {
  description = "ID of network interface"
  default = 0
  type=number
}
variable "credit_specification_cpu_credits" {
  description = "CPU Credits"
  default = "unlimited"
  type=string
}