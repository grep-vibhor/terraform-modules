#####################################
### SERVICE CONTROL POLICIES ########
#####################################

data "aws_iam_policy_document" "iam_policy_document" {

  statement {
    sid = var.sid
    effect = var.effect
    actions = var.actions
    resources = var.resources

    dynamic "condition" {
      for_each = var.condition
      content {
        test  = var.test
        variable = var.variable
        values = var.values
      }
    }

    dynamic "principals" {
      for_each = var.principals
      content {
        identifiers = var.identifiers
        type        = var.type
      }
    }

    dynamic "not_principals" {
      for_each = var.not_principals
      content {
        identifiers = var.identifiers
        type        = var.type
      }
    }
  }
}

##########################################################################

# Support replication ARNs
dynamic "statement" {
  for_each = flatten(data.aws_iam_policy_document.deny_network_changes.*.statement)
  content {
    actions       = lookup(statement.value, "actions", null)
    effect        = lookup(statement.value, "effect", null)
    not_actions   = lookup(statement.value, "not_actions", null)
    not_resources = lookup(statement.value, "not_resources", null)
    resources     = lookup(statement.value, "resources", null)
    sid           = lookup(statement.value, "sid", null)

    dynamic "condition" {
      for_each = lookup(statement.value, "condition", [])
      content {
        test     = condition.value.test
        values   = condition.value.values
        variable = condition.value.variable
      }
    }

    dynamic "not_principals" {
      for_each = lookup(statement.value, "not_principals", [])
      content {
        identifiers = not_principals.value.identifiers
        type        = not_principals.value.type
      }
    }

    dynamic "principals" {
      for_each = lookup(statement.value, "principals", [])
      content {
        identifiers = principals.value.identifiers
        type        = principals.value.type
      }
    }
  }
}

################################################
### SERVICE CONTROL POLICIES ORGANIZATIONS #####
################################################

resource "aws_organizations_policy" "restrict_regions_and_iam_changes" {
  name        = var.restrict_regions_and_iam_policy_name
  description = var.restrict_regions_and_iam_policy_description
  type        = var.policy_type
  content     = data.aws_iam_policy_document.restrict_regions_and_iam_changes.json
}

################################################
### SERVICE CONTROL POLICIES ATTACHMENT ########
################################################

resource "aws_organizations_policy_attachment" "deny_network_changes" {
  policy_id = aws_organizations_policy.deny_network_changes.id
  target_id = module.ventures_organization_unit.ou_id
}


