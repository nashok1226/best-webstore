data "aws_ami" "main" {
  most_recent = true
  owners      = [var.ami_owners]

  filter {
    name   = "name"
    values = [var.ami_name_string]
  }
}

resource "aws_instance" "main" {
  instance_type          = var.ec2_type
  ami                    = data.aws_ami.main.id
  subnet_id              = random_shuffle.private_subnet.result[0]
  vpc_security_group_ids = [var.private_sg]

  root_block_device {
    volume_size = var.ec2_vol_size
  }

  tags = {
    Name = var.ec2_name
  }

  user_data = var.user_data

  #depends_on = [ module.vpc.natgw_route ]
}

resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = var.lb_target_group
  target_id        = aws_instance.main.id
  port             = var.lb_tg_port


}