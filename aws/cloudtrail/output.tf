output "cloudtrail_arn" {
  value = aws_cloudtrail.cloudtrail.arn
}

output "cloudtrail_home" {
  value = aws_cloudtrail.cloudtrail.home_region
}