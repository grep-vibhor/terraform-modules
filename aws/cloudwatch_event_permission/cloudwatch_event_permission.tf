resource "aws_cloudwatch_event_permission" "cloudwatch_event_permission" {
  principal    = var.principal
  statement_id = var.statement_id
  condition {
    key   = var.key
    type  = var.type
    value = var.value
  }
}