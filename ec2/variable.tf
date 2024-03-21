variable "ec2_name" {}
variable "ec2_type" {}
variable "ec2_vol_size" {}
variable "instance_profile" {}
variable "private_subnet" {}
variable "lb_target_group" {}
variable "lb_tg_port" {}
variable "private_sg" {}
resource "random_shuffle" "private_subnet" {
  input = var.private_subnet
}