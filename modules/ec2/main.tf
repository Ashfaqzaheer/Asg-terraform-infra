resource "aws_instance" "web_server_a" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>🌐 Web Server A - Hello from EC2 A</h1>" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "web-server-a"
  }
}

resource "aws_instance" "web_server_b" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[1]
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>🚀 Web Server B - Hello from EC2 B</h1>" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "web-server-b"
  }
}