#### For Master ####

resource "aws_guardduty_organization_admin_account" "guardduty_admin" {
  admin_account_id = var.delegate_account
}