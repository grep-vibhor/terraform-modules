resource "aws_cloudwatch_event_rule" "cloudwatch_rule" {
  name                = var.rule_name
  description         = var.rule_description
  event_pattern       = var.event_pattern
  role_arn            = var.rule_role_arn
  is_enabled          = var.is_enabled
  schedule_expression = var.schedule_expression

}

resource "aws_cloudwatch_event_target" "rule_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_rule.name
  target_id = var.target_id
  arn       = var.target_arn
  role_arn  = var.rule_role_arn
}