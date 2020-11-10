output "http_target_arn" {
  value = aws_lb_target_group.http.arn
}

output "loadbalancer_arn" {
  value       = aws_lb.main.arn
}

output "listener_http_arn" {
  value       = aws_lb_listener.http.arn
}

output "listener_rule_arn" {
  value       = aws_lb_listener_rule.default.arn
}

output "alb_dns_endpoint" {
  value = aws_lb.main.dns_name
}

output "alb_zone_id" {
  value = aws_lb.main.zone_id
}