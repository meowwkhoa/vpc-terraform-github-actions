resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "VPC group 12"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "IGW group 12"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = var.az

  tags = {
    Name = "Public Subnet group 12"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.az

  tags = {
    Name = "Private Subnet group 12"
  }
}


resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.main_vpc.id

}

data "aws_caller_identity" "current" {}


resource "aws_kms_key" "log_group_kms_key12" {
  description             = "KMS key for encrypting CloudWatch log group"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = "kms:*",
        Resource = "*"
      },
      {
        Effect = "Allow",
        Principal = {
          Service = "logs.${var.region}.amazonaws.com"
        },
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_kms_alias" "log_group_kms_alias12" {
  name          = "alias/log-group-kms-key12"
  target_key_id = aws_kms_key.log_group_kms_key12.id
}



resource "aws_cloudwatch_log_group" "vpc_flow_log_group12" {
  name = "group12-vpc-flow-logs12"
  retention_in_days = 365 
  kms_key_id = aws_kms_key.log_group_kms_key12.arn

  depends_on = [aws_kms_key.log_group_kms_key12]
}


resource "aws_flow_log" "vpc_flow_log12" {
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow_log_group12.arn
  vpc_id               = aws_vpc.main_vpc.id
  traffic_type         = "ALL"

  
  iam_role_arn = aws_iam_role.vpc_flow_log_role12.arn
}


resource "aws_iam_role" "vpc_flow_log_role12" {
  name = "vpcFlowLogRole12"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy" "vpc_flow_log_policy12" {
  role = aws_iam_role.vpc_flow_log_role12.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "${aws_cloudwatch_log_group.vpc_flow_log_group12.arn}:*"
      }
    ]
  })
}
