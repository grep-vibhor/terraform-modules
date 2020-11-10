output "alb-name" {
  value = aws_alb.main.name
}

output "alb-arn" {
  value = aws_alb.main.arn
}

output "dns-name" {
  value = aws_alb.main.dns_name
}

output "alb-arn-suffix" {
  value = aws_alb.main.arn_suffix
}

output "alb-zone-id" {
  value = aws_alb.main.*.zone_id
}
output "http_tg_arn" {
  value = aws_alb_target_group.http_tg.arn
}
output "https_tg_arn" {
  value = aws_alb_target_group.https_tg.*.arn
}
output "alb-listener-80-arn" {
  value = aws_lb_listener.port80.arn
}
output "alb-listener-80-id" {
  value = aws_lb_listener.port80.id
}
output "alb-listener-443-arn" {
  value = aws_lb_listener.if_required_port443.*.arn
}
output "alb-listener-443-id" {
  value = aws_lb_listener.if_required_port443.*.id
}