data "template_file" "aws_config_policy" {
  template = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "AWSConfigBucketPermissionsCheck",
        "Effect": "Allow",
        "Action": "s3:GetBucketAcl",
        "Resource": "$${bucket_arn}"
    },
    {
        "Sid": "AWSConfigBucketExistenceCheck",
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "$${bucket_arn}"
    },
    {
        "Sid": "AWSConfigBucketDelivery",
        "Effect": "Allow",
        "Action": "s3:PutObject",
        "Resource": "$${resource}",
        "Condition": {
          "StringLike": {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
    }
  ]
}
JSON


  vars = {
    bucket_arn = format("arn:aws:s3:::${var.project}-config-logs-bucket")
    resource = format(
    "arn:aws:s3:::%s/%s/AWSLogs/%s/Config/*",
    var.config_logs_prefix,
    var.aws_account_id,
    )
  }
}

# Allow IAM policy to assume the role for AWS Config

data "aws_iam_policy_document" "aws_config_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    effect = "Allow"
  }
}

#
# IAM
#

resource "aws_iam_role" "main" {
  name               = "${var.project}-config-role"
  assume_role_policy = data.aws_iam_policy_document.aws_config_policy.json
}

resource "aws_iam_policy_attachment" "managed-policy" {
  name       = "${var.project}-config-managed-policy"
  roles      = [aws_iam_role.main.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_iam_policy" "aws-config-policy" {
  name   = "${var.project}-config-policy"
  policy = data.template_file.aws_config_policy.rendered
}

resource "aws_iam_policy_attachment" "aws-config-policy" {
  name       = "${var.project}-config-policy"
  roles      = [aws_iam_role.main.name]
  policy_arn = aws_iam_policy.aws-config-policy.arn
}