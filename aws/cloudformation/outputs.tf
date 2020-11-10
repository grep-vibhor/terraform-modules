output "cf_stackset_name" {
  value       = aws_cloudformation_stack_set.stackset.name
  description = "Name of the Stack Set"
}

output "cf_stackset_arn" {
  value       = aws_cloudformation_stack_set.stackset.arn
  description = "Name of the Stack Set"
}