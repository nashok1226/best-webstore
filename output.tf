output "s3_arn" {
  value = module.s3.bucket_arn
}

output "web_public-sg" {
  value = module.vpc.web_public_sg
}

output "web_private_sg" {
  value = module.vpc.web_private_sg
}