resource "aws_launch_template" "my_launch_template" {
  name_prefix            = "my_launch_template"
  image_id               = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_id]
  user_data              = filebase64("/root/terraform-practice/Day-4/user_data.sh")
}

resource "aws_autoscaling_group" "my_asg" {
  name                = "my_asg"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3
  vpc_zone_identifier = [var.private_subnet_1a_id, var.private_subnet_2b_id]
  target_group_arns   = [var.alb_tg_arn]
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
  health_check_type = "ELB"
}
