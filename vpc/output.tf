output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet" {
  value = aws_subnet.web-private.*.id
}

output "public_subnet" {
  value = aws_subnet.web-public.*.id
}

output "web_public_sg" {
  value = aws_security_group.web-public-sg.id
}

output "web_private_sg" {
  value = aws_security_group.web-private-sg.id
}