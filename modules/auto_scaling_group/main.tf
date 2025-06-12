resource "aws_autoscaling_group" "asg" {
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = "EC2"

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tag {
    key                  = "Name"
    value                = "ASG-Instance"
    propagate_at_launch = true
  }
}

