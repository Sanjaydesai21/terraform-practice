resource "aws_instance" "ec2-instance" {
  for_each = tomap({
    ec2-1 = "t3.micro"
    ec2-2 = "t3.small"
  })
  ami           = "ami-01a00762f46d584a1"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
