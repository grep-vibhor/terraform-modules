
/*
resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "${var.s3_bucket_name}-${var.account}"
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = "${var.s3_bucket_name}-${var.account}"

  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "${var.account}",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::cc-bloom-main-cloudtrail"
        },
        {
            "Sid": "AWSCloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
                "Resource": "arn:aws:s3:::${var.s3_bucket_name}-${var.account}/AWSLogs/${var.account}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
  }
  POLICY
}
*/

resource "aws_cloudtrail" "cloudtrail" {
  name                          = var.account
  s3_bucket_name                = var.s3_bucket_name
  #s3_key_prefix                 = "AWSLogs/${var.account}"
  include_global_service_events = var.include_global_service_events
  enable_logging                = var.enable_logging
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = var.enable_log_file_validation
  is_organization_trail         = var.is_organization_trail
  cloud_watch_logs_role_arn     = var.cloud_watch_logs_role_arn
  cloud_watch_logs_group_arn    = var.cloud_watch_logs_group_arn
  kms_key_id                    = var.kms_key_arn
  tags = {
    Name        = var.account
  }
  event_selector {
        read_write_type           = "All"
        include_management_events = true

        data_resource {
          type   = "AWS::S3::Object"
          values = ["arn:aws:s3:::"]
        }
      }
}


