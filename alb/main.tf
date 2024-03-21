resource "aws_lb" "main" {
  name            = var.alb_name
  subnets         = var.public_subnet
  security_groups = [var.web_public_sg]
  idle_timeout    = 300

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "main" {

  name     = join("-", [var.alb_name, "tg"])
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.tg_timeout
    interval            = var.tg_interval
  }

  tags = {
    Name = join("-", [var.alb_name, "tg"])
  }

}

resource "aws_lb_listener" "main" {

  load_balancer_arn = aws_lb.main.arn
  port              = var.listner_port
  protocol          = var.listner_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = {
    Name = join("-", [var.alb_name, "listner"])
  }
}