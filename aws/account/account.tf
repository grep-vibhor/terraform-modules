
resource "aws_organizations_account" "account" {
  name                       = var.account
  email                      = var.email
  iam_user_access_to_billing = var.billing_access
  parent_id                  = var.parent_id
  role_name                  = var.role_name
  tags = {
    Name = var.account
  }
  lifecycle {
    ignore_changes = [role_name]
  }
}