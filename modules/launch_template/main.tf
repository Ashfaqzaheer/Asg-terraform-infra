resource "aws_launch_template" "web_template" {
  name_prefix   = "webserver-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>🔥 Auto-scaled Web Server - Instance ID: $(curl http://169.254.169.254/latest/meta-data/instance-id)</h1>" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF
  )

  vpc_security_group_ids = [var.security_group_id]
}
