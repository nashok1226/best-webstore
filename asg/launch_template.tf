data "aws_ami" "main" {
  most_recent = true
  owners      = [var.ami_owners]

  filter {
    name   = "name"
    values = [var.ami_name_string]
  }
}

resource "aws_launch_template" "main" {

  name          = join("-", [var.lt_name, "launch-template"])
  image_id      = data.aws_ami.main.id
  instance_type = var.instance_type

  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [var.ec2_sg_id]
  user_data              = base64encode(var.user_data)

  tags = {
    Name = join("-", [var.lt_name, "launch-template"])
  }

  iam_instance_profile {
    name = var.instance_profile
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = join("-", [var.lt_name, "asg"])
    }

  }
}