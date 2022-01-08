resource "aws_instance" "foo" {
  ami           = var.ami # us-west-2
  instance_type = var.instance_type

  network_interface {
    network_interface_id = var.aws_network_interface_id
    device_index         = var.device_index
  }

  credit_specification {
    cpu_credits = var.credit_specification_cpu_credits
  }
}