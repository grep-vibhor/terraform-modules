variable "environment" {
  description = "Codebuild environment name"
}

#variable "module_depends_on" {default = [""]}

variable "codebuild_name" {}
variable "codebuild_description" {}
variable "role_arn" {}

variable "build_image" {
  type        = string
  default     = "aws/codebuild/standard:2.0"
  description = "Docker image for build environment, e.g. 'aws/codebuild/standard:2.0' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html"
}

variable "build_compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = "Instance type of the build instance"
}

variable "privileged_mode" {
  type        = bool
  default     = "true"
  description = "(Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images"
}

variable "repo_source" {}

variable "repo_identifier" {
  default = "CODECOMMIT"
}

variable "codebuild_log_group" {}
variable "codebuild_log_group_stream_name" {}
variable "environment_variables" {
  type = list(object(
  {
    name = string
    value = string
  }))
}

variable "buildspec" {}