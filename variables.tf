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
# ---------------------------------------------------------------------------------------------------------------------
# DEFAULT VARIABLES
# ---------------------------------------------------------------------------------------------------------------------