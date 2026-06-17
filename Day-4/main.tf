resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my_vpc"
  }

}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_1a_cidr
  availability_zone       = var.public_subnet_az_1a
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1a"
  }
}

resource "aws_subnet" "public_subnet_2b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_2b_cidr
  availability_zone       = var.public_subnet_az_2b
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2b"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_1a_cidr
  availability_zone = var.private_subnet_az_1a

  tags = {
    Name = "private_subnet_1a"
  }
}

resource "aws_subnet" "private_subnet_2b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_2b_cidr
  availability_zone = var.private_subnet_az_2b

  tags = {
    Name = "private_subnet_2b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.public_subnet_1a.id
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "nat_gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc_2b" {
  subnet_id      = aws_subnet.public_subnet_2b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_rt_assoc_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_assoc_2b" {
  subnet_id      = aws_subnet.private_subnet_2b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "my_sg" {
  name   = "my_sg"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my_sg"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    path = "/"
  }
}

resource "aws_lb" "my_lb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_2b.id]
  tags = {
    Name = "my_lb"
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {

    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_launch_template" "my_launch_template" {
  name_prefix            = "my_launch_template"
  image_id               = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data              = filebase64("/root/terraform-practice/Day-4/user_data.sh")
}

resource "aws_autoscaling_group" "my_asg" {
  name                = "my_asg"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3
  vpc_zone_identifier = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_2b.id]
  target_group_arns   = [aws_lb_target_group.tg.arn]
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
  health_check_type = "ELB"
}
