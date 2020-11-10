//data "aws_iam_policy_document" "aws-cloudformation-stackset-administration-role-policy" {
//  statement {
//    actions = ["sts:AssumeRole"]
//    effect  = "Allow"
//
//    principals {
//      identifiers = ["cloudformation.amazonaws.com"]
//      type        = "Service"
//    }
//  }
//}
//
//resource "aws_iam_role" "aws-cloudformation-stackset-administration-role" {
//  assume_role_policy = data.aws_iam_policy_document.aws-cloudformation-stackset-administration-role-policy.json
//  name               = var.stack_admin_role
//}
//
//data "aws_iam_policy_document" "aws-cloudformation-stackset-administration-policy" {
//  statement {
//    actions   = ["sts:AssumeRole"]
//    effect    = "Allow"
//    resources = ["arn:aws:iam::*:role/${aws_cloudformation_stack_set.stackset.execution_role_name}"]
//  }
//}
//
//resource "aws_iam_role_policy" "aws-cloudformation-stackset-administration-policy" {
//  name   = "ExecutionPolicy"
//  policy = data.aws_iam_policy_document.aws-cloudformation-stackset-administration-policy.json
//  role   = aws_iam_role.aws-cloudformation-stackset-administration-role.name
//}

resource "aws_cloudformation_stack_set" "stackset" {
  administration_role_arn = var.stack_admin_role
  execution_role_name     = "VentureAdminRole"
  name                    = var.stackname
  capabilities            = ["CAPABILITY_NAMED_IAM"]
  parameters              = var.parameters
  template_body           = var.template_body
  timeouts {
    update = "3h"
  }
}