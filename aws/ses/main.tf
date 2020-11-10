/*
Create SES domain identity and verify it with Route53 DNS records
*/

###################################
######## SES EMAIL IDENTITY #######
###################################

resource "aws_ses_email_identity" "email" {
  email = var.ses_from
}

#######################################
######## SES SNS DESTINATION ##########
#######################################

resource "aws_ses_configuration_set" "sns" {
  name = "${var.project}-${var.environment}-ses-configuration-set"
}

resource "aws_ses_event_destination" "sns" {
  name                   = "${var.project}-${var.environment}-event-destination-sns"
  configuration_set_name = aws_ses_configuration_set.sns.name
  enabled                = true
  matching_types         = ["bounce", "complaint", "delivery"]

  sns_destination {
    topic_arn = var.topic_arn
  }
}

#######################################
######## SES NOTIFICATION TOPIC #######
#######################################

resource "aws_ses_identity_notification_topic" "bounce" {
  topic_arn                = var.topic_arn
  notification_type        = "Bounce"
  identity                 = aws_ses_email_identity.email.arn
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "complaint" {
topic_arn                = var.topic_arn
notification_type        = "Complaint"
identity                 = aws_ses_email_identity.email.arn
include_original_headers = true
}

//resource "aws_ses_identity_notification_topic" "delivery" {
//topic_arn                = var.topic_arn
//notification_type        = "Delivery"
//identity                 = aws_ses_email_identity.email.arn
//include_original_headers = true
//}

###################################
######## SES EMAIL TEMPLATE #######
###################################

data "template_file" "ses_template" {
  template = file("${path.module}/ses-mail.tmpl")
}

resource "aws_ses_template" "mail_template" {
  name    = var.template_name
  subject = var.template_subject
  html    = data.template_file.ses_template.rendered
  text    = var.text
}
