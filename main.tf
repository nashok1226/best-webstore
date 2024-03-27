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
  user_data        = file("${path.cwd}/ec2_install_apache.sh")
  ami_name_string  = var.ami_name_string
  ami_owners       = var.ami_owners

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

module "asg" {
  source                  = "./asg"
  instance_type           = var.ec2_type
  ami_id                  = ""
  ec2_sg_id               = module.vpc.web_private_sg
  user_data               = file("${path.cwd}/ec2_install_apache.sh")
  lt_name                 = var.launch_template_name
  ami_name_string         = var.ami_name_string
  ami_owners              = var.ami_owners
  instance_profile        = module.iam.ec2_instance_profile
  private_subnet          = module.vpc.private_subnet
  target_group_arns       = module.alb.lb_target_group
  asg_max_size            = var.asg_max_size
  asg_min_size            = var.asg_min_size
  asg_desired_size        = var.asg_desired_size
  health_grace_period     = var.health_grace_period
  auto_scale_cooldown     = var.auto_scale_cooldown
  scaleup_cpu_threshold   = var.scaleup_cpu_threshold
  scaledown_cpu_threshold = var.scaledown_cpu_threshold
  scale_grace_priod       = var.scale_grace_priod
  scale_eval_time_period  = var.scale_eval_time_period

}
