output "ec2_s3_policy_arn" {
  value = aws_iam_policy.main.id
}

output "ec2_instance_profile" {
  value = aws_iam_instance_profile.main.name
}