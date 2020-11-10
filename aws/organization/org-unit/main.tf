#######################################
######## AWS ORGANIZATION UNIT ########
#######################################

resource "aws_organizations_organizational_unit" "default" {
  name      = var.name
  parent_id = var.parent_id
}
