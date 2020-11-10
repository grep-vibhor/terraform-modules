variable "ses_from" {}

variable "template_name" {}

variable "template_subject" {}

variable "text" {}

variable "ses_records" {
  type        = list(string)
  description = "Additional entries which are added to the _amazonses record"
  default     = []
}

variable "topic_arn" {}
variable "environment" {}
variable "project" {}