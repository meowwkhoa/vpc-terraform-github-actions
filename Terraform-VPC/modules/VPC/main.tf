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


