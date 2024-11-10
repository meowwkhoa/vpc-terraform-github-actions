resource "aws_instance" "public" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  security_groups = [var.public_security_group]
  ebs_optimized = true
  monitoring = true

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "Public Instance group 12"
  }
}

resource "aws_instance" "private" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  security_groups = [var.private_security_group]
  ebs_optimized = true
  monitoring = true

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_tokens = "required"
  }


  tags = {
    Name = "Private Instance group 12"
  }
}


