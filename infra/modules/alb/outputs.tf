output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "target_group_blue_arn" {
  value = aws_lb_target_group.blue.arn
}

output "target_group_green_arn" {
  value = aws_lb_target_group.green.arn
}


