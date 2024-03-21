resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = join("-", [var.vpc_name, "igw"])
  }

}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = join("-", [var.vpc_name, "public-rt"])
  }

}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

}


resource "aws_route_table_association" "tf-public" {
  count          = length(var.public_cidrs)
  route_table_id = aws_route_table.main.id
  subnet_id      = aws_subnet.web-public.*.id[count.index]

}