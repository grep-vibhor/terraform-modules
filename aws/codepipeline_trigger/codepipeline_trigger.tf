resource "aws_cloudwatch_event_rule" "pipeline_trigger" {
  name        = var.codepipeline_rule
  description = "Capture all codecommit repo change events"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "CodeCommit Repository State Change"
  ],
  "resources": [
    "arn:aws:codecommit:${var.aws_region}:${var.account_id}:${var.repo_name}"
  ],
  "source": [
    "aws.codecommit"
  ],
  "detail": {
    "referenceType": [
      "branch"
    ],
    "event": [
      "referenceCreated",
      "referenceUpdated"
    ],
    "referenceName": [
      "${var.default_branch}"
    ]
  }
}
PATTERN
}


resource "aws_cloudwatch_event_target" "pipeline_trigger" {
  rule      = aws_cloudwatch_event_rule.pipeline_trigger.name
  arn       = var.codepipeline_arn
  role_arn = var.codepipeline_role_arn
}