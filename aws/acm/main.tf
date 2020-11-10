###################
# AWS certificate
###################

resource "aws_acm_certificate" "primary" {
  domain_name = var.domain
  subject_alternative_names = var.subject_alternative_names
  validation_method = "DNS"
  tags = {
    Name = var.name
  }
}

resource "aws_route53_record" "cert_validation" {
//  for_each = {
//      for dvo in aws_acm_certificate.primary.domain_validation_options : dvo.domain_name => {
//        name   = dvo.resource_record_name
//        record = dvo.resource_record_value
//        type   = dvo.resource_record_type
//      }
//  }
  name    = aws_acm_certificate.primary.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.primary.domain_validation_options.0.resource_record_type
  records = [aws_acm_certificate.primary.domain_validation_options.0.resource_record_value]
  zone_id = var.route53_zone_id
  allow_overwrite = true
  ttl     = 86400
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.primary.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}