resource "aws_eip" "main" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.web-public.0.id

}

resource "aws_route_table" "tf-private-rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = join("-", [var.vpc_name, "private-rt"])
  }

}

resource "aws_route" "natgw_route" {
  route_table_id         = aws_route_table.tf-private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id

}

resource "aws_route_table_association" "tf-private" {
  count          = length(var.public_cidrs)
  route_table_id = aws_route_table.tf-private-rt.id
  subnet_id      = aws_subnet.web-private.*.id[count.index]

}