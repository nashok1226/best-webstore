resource "aws_autoscaling_group" "main" {

  name                      = join("-", [var.lt_name, "asg"])
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.health_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.asg_desired_size
  force_delete              = true
  termination_policies      = ["OldestInstance"]
  target_group_arns         = [var.target_group_arns]
  vpc_zone_identifier       = var.private_subnet

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = join("-", [var.lt_name, "asg"])
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_policy" "auto_scale_up" {
  name                   = join("-", [var.lt_name, "auto-scale-up"])
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.auto_scale_cooldown
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = join("-", [var.lt_name, "cpu-alarm-up"])
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scale_eval_time_period
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.scale_grace_priod
  statistic           = "Average"
  threshold           = var.scaleup_cpu_threshold
  alarm_description   = "To monitor Average CPU Utilization of web-fe servers"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [aws_autoscaling_policy.auto_scale_up.arn]
}

resource "aws_autoscaling_policy" "auto_scale_down" {
  name                   = join("-", [var.lt_name, "auto-scale-down"])
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.auto_scale_cooldown
  autoscaling_group_name = aws_autoscaling_group.main.name

}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name          = join("-", [var.lt_name, "cpu-alarm-down"])
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.scale_eval_time_period
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.scale_grace_priod
  statistic           = "Average"
  threshold           = var.scaledown_cpu_threshold
  alarm_description   = "To monitor Average CPU Utilization of web-fe servers"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [aws_autoscaling_policy.auto_scale_down.arn]
}