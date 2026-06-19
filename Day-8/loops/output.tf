output "public_ip" {
  value = [for ec2 in aws_instance.ec2-instance : ec2.public_ip]
}
