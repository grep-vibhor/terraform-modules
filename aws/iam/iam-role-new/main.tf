###########################
#### Create IAM Roles #####
###########################

resource "aws_iam_role" "roles" {
  name        = var.role_name
  path        = var.path
  description = var.role_description

  # This policy defines who/what is allowed to use the current role
  assume_role_policy = var.assume_role_policy

  # The boundary defines the maximum allowed permissions which cannot exceed.
  # Even if the policy has higher permission, the boundary sets the final limit
  permissions_boundary = var.permissions_boundary

  # Allow session for X seconds
  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies

  tags = {
    Name = var.role_name
  }
}

##################################
#### Attach Policies to Role #####
##################################

# Attach customer managed policies
resource "aws_iam_role_policy_attachment" "custom_policy_attachments" {
  role       = aws_iam_role.roles.name
  policy_arn = var.policy_arn

  depends_on = [
    aws_iam_role.roles,
  ]
}

resource "aws_iam_role_policy_attachment" "aws_managed_policy" {
  count      = length(var.aws_managed_policy)
  role       = aws_iam_role.roles.name
  policy_arn = var.aws_managed_policy[count.index]
}