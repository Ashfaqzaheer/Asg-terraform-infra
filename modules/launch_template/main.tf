data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "asg_template" {
  name_prefix   = "asg-template-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = var.key_name

  network_interfaces {
    security_groups             = [var.security_group_id]
    associate_public_ip_address = true
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd stress
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<h1>🌿 Instance from ASG - ID: $INSTANCE_ID</h1>" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
EOF
  )
}
