output "cloudwatch_event_arn" {
  value       = aws_cloudwatch_event_rule.pipeline_trigger.arn
}