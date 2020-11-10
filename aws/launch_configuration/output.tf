// A comma-separated list of subnet IDs.
output "launch_configuration_name" {
  value = aws_launch_configuration.main.name
}