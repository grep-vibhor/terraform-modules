resource "aws_organizations_organizational_unit" "org_unit" {
  name      = var.name
  parent_id = var.parent_id
}