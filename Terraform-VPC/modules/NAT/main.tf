resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "NAT EIP group 12"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  depends_on = [ aws_eip.nat_eip ]
  subnet_id = var.public_subnet_id

  tags = {
    Name = "NAT Gateway group 12"
  }
}

