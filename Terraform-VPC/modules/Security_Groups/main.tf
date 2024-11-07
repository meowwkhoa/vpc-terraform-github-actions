resource "aws_security_group" "public" {
  vpc_id = var.vpc_id
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
    description = "SSH access for specific IPs"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Unrestricted outbound access"
  }

  tags = {
    Name = "Group 12: Public Security Group"
  }
}

resource "aws_security_group" "private" {
  vpc_id = var.vpc_id
  description = "Private security group allowing SSH access from the public security group and unrestricted outbound traffic"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
    description     = "Allow SSH access from the public security group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow unrestricted outbound traffic"
  }

  tags = {
    Name = "Group 12: Private Security Group"
  }
}