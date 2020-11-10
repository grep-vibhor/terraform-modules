resource "aws_codecommit_repository" "ven_repo" {
  repository_name = var.account
  description     = "The ${var.account} Repository"
  default_branch  = var.default_branch
}