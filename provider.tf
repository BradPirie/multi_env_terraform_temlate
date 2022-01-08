# ---------------------------------------------------------------------------------------------------------------------
# AWS PROVIDER FOR TF CLOUD
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "${terraform.workspace}"
      Owner       = "Terraform OPS"
      CreatedBy   = "Terraform Framework"
    }
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.51"
    }
  }
}
