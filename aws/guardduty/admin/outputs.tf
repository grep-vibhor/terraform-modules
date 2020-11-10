output "guardduty_master" {
  value = aws_guardduty_organization_admin_account.guardduty_admin.id
}