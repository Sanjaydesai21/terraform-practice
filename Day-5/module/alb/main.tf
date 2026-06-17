resource "aws_lb_target_group" "tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/"
  }
}

resource "aws_lb" "my_lb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.vpc_security_group_id]
  subnets            = [var.public_subnet_1a_id, var.public_subnet_2b_id]
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
