resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_subnet" "web-public" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = {
    Name = join("-", [var.vpc_name, "public-subnet", tostring("${count.index + 1}")])
  }

}

resource "aws_subnet" "web-private" {
  count             = length(var.private_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = random_shuffle.az_list.result[count.index]

  tags = {
    Name = join("-", [var.vpc_name, "private-subnet", tostring("${count.index + 1}")])
  }


}