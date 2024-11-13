resource "aws_iam_role" "ec2_role12" {
  name               = "ec2_role12"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_role_policy12" {
  role   = aws_iam_role.ec2_role12.id
  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": [
            "s3:ListBucket"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::my_bucket"
        }
      ]
    }
  )
}




resource "aws_instance" "public" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_id
  security_groups   = [var.public_security_group]
  ebs_optimized     = true
  monitoring        = true
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile12.name 

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

resource "aws_iam_instance_profile" "ec2_instance_profile12" {
  name = "ec2_instance_profile12"
  role = aws_iam_role.ec2_role12.name
}



resource "aws_instance" "private" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  security_groups = [var.private_security_group]
  ebs_optimized = true
  monitoring = true
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile12.name

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


