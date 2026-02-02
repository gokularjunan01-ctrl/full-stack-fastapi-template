resource "aws_security_group" "app_sg" {
  name = "fullstack-app-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  count         = var.create_infra ? 1 : 1
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.small"

  key_name = "devops-key"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = file("${path.module}/data.sh")

  tags = {
    Name = "fullstack-fastapi-app"
  }
}
