variable "vpc_cidr" {}
variable "private_cidrs" {}
variable "public_cidrs" {}
variable "vpc_name" {}
variable "public_sg_name" {}
variable "private_sg_name" {}
variable "lb_listner_port" {}
variable "ec2_web_port" {}
variable "public_access_cidr" {}

data "aws_availability_zones" "available" {
  state = "available"

}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = 20

}