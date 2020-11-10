output "mail_template" {
  value = aws_ses_template.mail_template.id
}

output "ses_email_identity_arn" {
  description = "The ARN of the domain identity"
  value       = aws_ses_email_identity.email.arn
}
