output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "public_subnet_2b_id" {
  value = aws_subnet.public_subnet_2b.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}

output "private_subnet_2b_id" {
  value = aws_subnet.private_subnet_2b.id
}

output "vpc_security_group_id" {
  value = aws_security_group.my_sg.id
}
