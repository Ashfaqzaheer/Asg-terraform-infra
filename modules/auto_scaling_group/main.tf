resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  target_group_arns    = [var.target_group_arn]
  health_check_type    = "ELB"

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "autoscaled-web"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_policy" {
  name                   = "cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}
