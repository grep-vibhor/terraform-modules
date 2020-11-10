output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.primary.arn
}

output "acm_certificate_id" {
  description = "The ID of the certificate"
  value       = aws_acm_certificate.primary.id
}

