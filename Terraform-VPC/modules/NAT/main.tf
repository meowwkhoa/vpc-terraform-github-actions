resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  depends_on = [ aws_eip.nat_eip ]
  subnet_id = var.public_subnet_id
}

