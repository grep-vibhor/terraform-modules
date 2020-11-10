resource "aws_codebuild_project" "code_build" {
  name          = var.codebuild_name
  description   = var.codebuild_description
  build_timeout = "60"
  service_role  = var.role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = var.build_compute_type
    image                       = var.build_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.privileged_mode

   dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_log_group
      stream_name = var.codebuild_log_group_stream_name
    }
  }

  source {
    type     = var.repo_identifier
    location = var.repo_source
    buildspec = var.buildspec
  }

  tags = {
    Name          = var.codebuild_name
    Environment = var.environment
  }

}
