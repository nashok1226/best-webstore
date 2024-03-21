
resource "aws_security_group" "web-public-sg" {
  name   = var.public_sg_name
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.public_sg_name
  }

}

resource "aws_vpc_security_group_ingress_rule" "public-http-ingress" {
  security_group_id = aws_security_group.web-public-sg.id
  from_port         = var.lb_listner_port
  to_port           = var.lb_listner_port
  ip_protocol       = "tcp"
  cidr_ipv4         = var.public_access_cidr

}

resource "aws_vpc_security_group_egress_rule" "public-egress" {
  security_group_id = aws_security_group.web-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}

resource "aws_security_group" "web-private-sg" {
  name   = var.private_sg_name
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.private_sg_name
  }

}

resource "aws_vpc_security_group_ingress_rule" "private-http-ingress" {
  security_group_id            = aws_security_group.web-private-sg.id
  from_port                    = var.ec2_web_port
  to_port                      = var.ec2_web_port
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.web-public-sg.id

}


resource "aws_vpc_security_group_egress_rule" "private-egress" {
  security_group_id = aws_security_group.web-private-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}