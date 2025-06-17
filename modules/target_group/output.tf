output "tg_asg" {
  value = aws_lb_target_group.tg_asg.arn
}

output "tg_asg_arn" {
  value = aws_lb_target_group.tg_asg.arn
}

output "tg_server_a" {
  value = aws_lb_target_group.tg_server_a.arn
}

output "tg_server_b" {
  value = aws_lb_target_group.tg_server_b.arn
}
