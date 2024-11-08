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

  ingress {
    protocol  = "-1"
    self      = true
    from_port = 0
    to_port   = 0
    cidr_blocks = aws_vpc.main_vpc.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "public" {
  source = "../Security_Groups"
  vpc_id = aws_vpc.main_vpc.id
  allowed_ip = var.allowed_ip
}

module "private" {
  source = "../Security_Groups"
  vpc_id = aws_vpc.main_vpc.id
  allowed_ip = var.allowed_ip
}

resource "aws_network_interface" "public" {
  subnet_id = aws_subnet.public_subnet.id
  security_groups = [module.public.public_security_group_id]
}

resource "aws_network_interface" "private" {
  subnet_id = aws_subnet.private_subnet.id
  security_groups = [module.private.private_security_group_id]
}

resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.iam_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_log.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main_vpc.id
}

resource "aws_cloudwatch_log_group" "vpc_flow_log" {
  name = "vpc_flow_log"
  retention_in_days = 7
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role" {
  name               = "role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "role_policy" {
  name   = "role_policy"
  role   = aws_iam_role.iam_role.name
  policy = data.aws_iam_policy_document.policy.json
}