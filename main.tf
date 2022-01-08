module "network" {
  source = "./modules/network"

  aws_account_id      = var.aws_account_id
  aws_azs             = var.azs
  aws_region          = var.aws_region

  vpc_cidr_block                = ""
  subnet_cidr_block             = ""
  network_interface_private_ips = []
}

module "ec2" {
  source = "./modules/ec2"

  aws_account_id      = var.aws_account_id
  aws_azs             = var.azs
  aws_region          = var.aws_region

  ami                              = ""
  instance_type                    = ""
  aws_network_interface_id = module.network.network_interface_id
  device_index                     = 0
  credit_specification_cpu_credits = ""

  depends_on = [
    module.network
  ]

}