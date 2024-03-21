## IAM + S3 
aws_s3_bucket_name            = "best-web-catalouge"
aws_iam_role_name             = "ec2_s3_role"
aws_iam_policy_name           = "ec2_s3_policy"
aws_iam_instance_profile_name = "ec2_s3_access"

## VPC
vpc_cidr = "10.0.0.0/17"
vpc_name = "web-fe-vpc"

## EC2
ec2_type        = "t2.micro"
ec2_vol_size    = 10
ec2_name        = "web-fe-server"
public_sg_name  = "web-public-sg"
private_sg_name = "web-private-sg"

## ALB
web_port            = 80
web_protocol        = "HTTP"
healthy_threshold   = 2
unhealthy_threshold = 2
tg_interval         = 30
tg_timeout          = 20
listner_protocol    = "HTTP"
listner_port        = 80
web_lb_name         = "web-http-lb"
public_access_cidr  = "0.0.0.0/0"

##ASG
launch_template_name    = "web-fe"
ami_owners              = "099720109477"
ami_name_string         = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
asg_max_size            = 6
asg_min_size            = 1
asg_desired_size        = 6
health_grace_period     = 300
auto_scale_cooldown     = 300
scaleup_cpu_threshold   = 80
scaledown_cpu_threshold = 20
scale_grace_priod       = 120
scale_eval_time_period  = 2
