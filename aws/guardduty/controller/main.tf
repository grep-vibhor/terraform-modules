#### For Security ####

resource "aws_guardduty_detector" "guardduty" {
  depends_on = [var.guardduty_depends_on]
  enable = true
}

resource "aws_guardduty_organization_configuration" "guardduty_org" {
  auto_enable = true
  detector_id = aws_guardduty_detector.guardduty.id
}

variable "guardduty_depends_on" {}