output "ec2_a_id" {
  value = aws_instance.web_server_a.id
}

output "ec2_b_id" {
  value = aws_instance.web_server_b.id
}