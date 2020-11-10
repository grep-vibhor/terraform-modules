resource "aws_codepipeline" "codepipeline" {
  depends_on = [null_resource.codebuild_exists]
  name       = var.codepipeline_name
  role_arn   = var.codepipeline_role_arn

  artifact_store {
      location = var.codepipeline_bucket_name
      type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName       = var.repo_name
        BranchName           = var.branch_name
        PollForSourceChanges = var.PollForSourceChanges
      }
    }
  }

  dynamic "stage" {
    for_each = var.stage_build == "" ? [] : [var.stage_build]
    content {
      name = "Build"
      action {
        name             = "Build"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source_output"]
        output_artifacts = ["build_output"]
        version          = "1"

        configuration = {
          ProjectName = var.codebuild_name
        }
      }
    }
  }

  dynamic "stage" {
    for_each = var.stage_deploy == "" ? [] : [var.stage_deploy]

    content {
      name = "Deploy"
      action {
        name            = "Deploy"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "ECS"
        input_artifacts = ["build_output"]
        version         = "1"

        configuration = {
          ClusterName = var.cluster_name,
          ServiceName = var.service_name,
          FileName    = var.file_name
        }
      }
    }
  }

  dynamic "stage" {
    for_each = var.stage_plan == "" ? [] : [var.stage_plan]

    content {
      name = "Plan"
      action {
        name             = "Plan"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source_output"]
        output_artifacts = ["plan_output"]
        version          = "1"

        configuration = {
          ProjectName = var.plan_codebuild_name
          EnvironmentVariables = jsonencode([
            {
              name  = "BRANCH_NAME"
              value = var.BRANCH_NAME
              type  = "PLAINTEXT"
            },
            {
              name  = "CROSS_ACCOUNT_CODEBUILD_ROLE_NAME"
              value = var.CROSS_ACCOUNT_CODEBUILD_ROLE_NAME
              type  = "PLAINTEXT"
            },
            {
              name  = "ACCOUNT_ID"
              value = var.ACCOUNT_ID
              type  = "PLAINTEXT"
            }
          ])
        }
      }
    }
  }

  dynamic "stage" {
    for_each = var.stage_approval == "" ? [] : [var.stage_approval]

    content {
      name = "Approval"
      action {
        name     = "Approval"
        category = "Approval"
        owner    = "AWS"
        provider = "Manual"
        version  = "1"
        configuration = {
          NotificationArn    = var.approve_sns_arn
          CustomData         = var.approve_comment
          ExternalEntityLink = var.approve_url
        }
      }
    }
  }

  dynamic "stage" {
    for_each = var.stage_apply == "" ? [] : [var.stage_apply]

    content {
      name = "Apply"
      action {
        name            = "Apply"
        category        = "Build"
        owner           = "AWS"
        provider        = "CodeBuild"
        input_artifacts = ["plan_output"]
        version         = "1"

        configuration = {
          ProjectName = var.apply_codebuild_name
          EnvironmentVariables = jsonencode([
            {
              name  = "BRANCH_NAME"
              value = var.BRANCH_NAME
              type  = "PLAINTEXT"
            },
            {
              name  = "CROSS_ACCOUNT_CODEBUILD_ROLE_NAME"
              value = var.CROSS_ACCOUNT_CODEBUILD_ROLE_NAME
              type  = "PLAINTEXT"
            },
            {
              name  = "ACCOUNT_ID"
              value = var.ACCOUNT_ID
              type  = "PLAINTEXT"
            }
          ])
        }
      }
    }
  }
}

resource "null_resource" "codebuild_exists" {
  triggers = {
    codebuild_exists = var.codebuild_name
  }
}
