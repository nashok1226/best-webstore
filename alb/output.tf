output "lb_target_group" {
  value = aws_lb_target_group.main.arn
}

output "web_lb_id" {
  value = aws_lb.main.id
}

output "web_fqdn" {
  value = join("",["http://",aws_lb.main.dns_name])
}