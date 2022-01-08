output "vpc_arn" {
  value = aws_vpc.my_vpc.arn
}

output "vpc_cidr_block" {
  value = aws_vpc.my_vpc.cidr_block
}

output "subnet_arn" {
  value = aws_subnet.my_subnet.arn
}

output "subnet_cidr_block" {
  value = aws_subnet.my_subnet.cidr_block
}

output "network_interface_id" {
  value = aws_network_interface.foo.id
}