module "s3" {
  source      = "./s3"
  bucket_name = var.aws_s3_bucket_name
}

module "iam" {
  source                        = "./iam"
  s3_arn                        = module.s3.bucket_arn
  aws_iam_policy_name           = var.aws_iam_policy_name
  aws_iam_role_name             = var.aws_iam_role_name
  aws_iam_instance_profile_name = var.aws_iam_instance_profile_name
}

module "vpc" {
  source             = "./vpc"
  vpc_cidr           = var.vpc_cidr
  private_cidrs      = [for i in range(2, 7, 2) : cidrsubnet(var.vpc_cidr, 7, i)]
  public_cidrs       = [for i in range(1, 7, 2) : cidrsubnet(var.vpc_cidr, 7, i)]
  vpc_name           = var.vpc_name
  security_groups    = local.security_groups
  public_sg_name     = var.public_sg_name
  private_sg_name    = var.private_sg_name
  ec2_web_port       = var.web_port
  lb_listner_port    = var.listner_port
  public_access_cidr = var.public_access_cidr

}

module "ec2" {
  source           = "./ec2"
  instance_profile = module.iam.ec2_instance_profile
  private_subnet   = module.vpc.private_subnet
  ec2_type         = var.ec2_type
  ec2_vol_size     = var.ec2_vol_size
  ec2_name         = var.ec2_name
  lb_target_group  = module.alb.lb_target_group
  lb_tg_port       = var.web_port
  private_sg       = module.vpc.web_private_sg

}

module "alb" {
  source              = "./alb"
  public_subnet       = module.vpc.public_subnet
  vpc_id              = module.vpc.vpc_id
  tg_port             = var.web_port
  tg_protocol         = var.web_protocol
  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  tg_interval         = var.tg_interval
  tg_timeout          = var.tg_timeout
  listner_protocol    = var.listner_protocol
  listner_port        = var.listner_port
  alb_name            = var.web_lb_name
  web_public_sg       = module.vpc.web_public_sg

}