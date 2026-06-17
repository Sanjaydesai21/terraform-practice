output "alb_dns" {
  value = aws_lb.my_lb.dns_name
}

output "alb_tg_arn" {
  value = aws_lb_target_group.tg.arn
}
