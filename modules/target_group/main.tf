resource "aws_lb_target_group" "tg_server_a" {
  name = "tg-server-a"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "attach_a" {
  target_group_arn = aws_lb_target_group.tg_server_a.arn
  target_id        = var.ec2_a_id
  port             = 80
}

resource "aws_lb_target_group" "tg_server_b" {
  name = "tg-server-b"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "attach_b" {
  target_group_arn = aws_lb_target_group.tg_server_b.arn
  target_id        = var.ec2_b_id
  port             = 80
}

resource "aws_lb_target_group" "tg_asg" {
  name = "tg-asg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}