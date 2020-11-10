###############################################
### SIMPLE NOTIFICATION AND QUEUE SERVICE #####
###############################################xz

resource "aws_sns_topic" "sns-alerts" {
  name = var.name
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 0,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
  tags = {
    Name        = var.name
    environment = var.environment
  }
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.sns-alerts.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}


data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "*"
    ]

    sid = "CodepipelineApproval"
  }
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  count     = var.create_subscription == true ? 1 : 0
  topic_arn = aws_sns_topic.sns-alerts.arn
  protocol  = var.subscription_protocol
  endpoint  = var.subscription_endpoint
  endpoint_auto_confirms = var.endpoint_auto_confirms
  raw_message_delivery = var.raw_message_delivery
}