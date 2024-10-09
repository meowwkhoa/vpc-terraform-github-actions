resource "aws_instance" "public" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  security_groups = [var.public_security_group]

  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "private" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  security_groups = [var.private_security_group]

  tags = {
    Name = "PrivateInstance"
  }
}


