output "config_id" {
  description = "Name of the recorder"
  value       = aws_config_configuration_recorder.main.id
}

output "config_delivery_channel_id" {
  description = "The name of the delivery channel."
  value       = aws_config_delivery_channel.main.id
}

output "bucket_arn" {
  description = "Name of the Config logs bucket created"
  value       = aws_s3_bucket.config.*.arn
}

