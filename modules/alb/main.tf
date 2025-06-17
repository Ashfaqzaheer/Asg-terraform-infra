resource "aws_lb" "main" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 - Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "a_path" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = var.tg_server_a
  }

  condition {
    path_pattern {
      values = ["/a*"]
    }
  }
}

resource "aws_lb_listener_rule" "b_path" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = var.tg_server_b
  }

  condition {
    path_pattern {
      values = ["/b*"]
    }
  }
}