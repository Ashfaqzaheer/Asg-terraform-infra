data "aws_autoscaling_group" "asg_data" {
  name = aws_autoscaling_group.asg.name
}

