variable "ami_id" {}
variable "instance_type" {}
variable "ec2_sg_id" {}
variable "user_data" {}
variable "lt_name" {}
variable "ami_name_string" {}
variable "ami_owners" {}
variable "instance_profile" {}
variable "private_subnet" {}
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "asg_desired_size" {}
variable "health_grace_period" {}
variable "target_group_arns" {}
variable "auto_scale_cooldown" {}
variable "scaleup_cpu_threshold" {}
variable "scaledown_cpu_threshold" {}
variable "scale_grace_priod" {}
variable "scale_eval_time_period" {}