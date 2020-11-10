output "organization_id" {
  value = aws_organizations_organization.bloom.roots.0.id
}