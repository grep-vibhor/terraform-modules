resource "aws_route53_zone" "primary" {
  name = var.name
  tags = {
    Environment = var.environment
  }
}