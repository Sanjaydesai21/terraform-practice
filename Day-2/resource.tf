data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_ami" "default_ami" {
  most_recent = true
  owners      = [var.owners_id]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key" {
  key_name   = "terraform-key"
  public_key = tls_private_key.generated.public_key_openssh

  tags = {
    Name = "terraform-key"
  }
}

resource "aws_security_group" "ec2_sg" {
  name   = "ec2_sg"
  vpc_id = data.aws_vpc.default_vpc.id

  ingress {
    from_port   = var.ingress_ssh
    to_port     = var.ingress_ssh
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    from_port   = var.ingress_http
    to_port     = var.ingress_http
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ingress_cidr]
  }
}

resource "aws_instance" "http_ec2" {
  ami                    = data.aws_ami.default_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = file("/root/terraform-practice/Day-2/user-data.sh")
  tags = {
    Name = "nginx_ec2"
  }
}



