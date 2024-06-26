variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_s3_bucket_name" {}
variable "aws_iam_role_name" {}
variable "aws_iam_policy_name" {}
variable "aws_iam_instance_profile_name" {}
variable "vpc_cidr" {}
variable "vpc_name" {}

variable "ec2_type" {}
variable "ec2_vol_size" {}
variable "ec2_name" {}
variable "ami_owners" {}
variable "ami_name_string" {}

variable "public_sg_name" {}
variable "private_sg_name" {}
variable "web_port" {}
variable "web_protocol" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "tg_interval" {}
variable "tg_timeout" {}
variable "listner_protocol" {}
variable "listner_port" {}
variable "web_lb_name" {}
variable "public_access_cidr" {}

variable "launch_template_name" {}
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "asg_desired_size" {}
variable "health_grace_period" {}
variable "auto_scale_cooldown" {}
variable "scaleup_cpu_threshold" {}
variable "scaledown_cpu_threshold" {}
variable "scale_grace_priod" {}
variable "scale_eval_time_period" {}