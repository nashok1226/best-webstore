variable "ami_owners" {}
variable "ami_name_string" {}
variable "ec2_name" {}
variable "ec2_type" {}
variable "ec2_vol_size" {}
variable "instance_profile" {}
variable "private_subnet" {}
variable "lb_target_group" {}
variable "lb_tg_port" {}
variable "private_sg" {}
variable "user_data" {}
resource "random_shuffle" "private_subnet" {
  input = var.private_subnet
}