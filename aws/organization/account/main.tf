##########################################
######## AWS ORGANIZATION ACCOUNT ########
##########################################

resource "aws_organizations_account" "account" {
  name                       = var.name
  email                      = var.email
  iam_user_access_to_billing = var.iam_user_access_to_billing
  parent_id                  = var.parent_id
  role_name                  = var.role_name
  tags = {
    Name = var.name
  }
  lifecycle {
    ignore_changes = [role_name]
  }
}
