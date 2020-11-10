output "parameter_arns" {
  value = [aws_ssm_parameter.pipeline_params.*.arn]
}

output "parameter_names" {
  value = [aws_ssm_parameter.pipeline_params.*.name]
}

output "parameter_values" {
  value = [aws_ssm_parameter.pipeline_params.*.value]
}