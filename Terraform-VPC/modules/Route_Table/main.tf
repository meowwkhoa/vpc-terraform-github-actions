resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
}

resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.gateway_id
}

resource "aws_route_table_association" "public_association" {
  subnet_id = var.public_subnet_id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = var.nat_gateway_id
}

resource "aws_route_table_association" "private_association" {
  subnet_id = var.private_subnet_id
  route_table_id = aws_route_table.private_route_table.id
}
