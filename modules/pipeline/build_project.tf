resource "random_id" "codebuild_build_lambda_function" {
  byte_length = 4
}

resource "aws_codebuild_project" "build_lambda_function" {
  name          = "build-letsencrypt-certs-aws-${random_id.codebuild_build_lambda_function.hex}${var.suffix}"
  badge_enabled = true
  build_timeout = "30"
  description   = "Build the letsencrypt-certs-aws Lambda function for ARM64"
  service_role  = aws_iam_role.build_lambda_function.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    name = "${var.s3_bucket}/codebuild-cache/"
    type = "S3"
  }

  environment {
    compute_type = "BUILD_GENERAL1_LARGE"
    image        = "aws/codebuild/amazonlinux2-aarch64-standard:2.0"
    type         = "ARM_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.build_lambda_function.name
      status     = "ENABLED"
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}

resource "random_id" "logs_build_lambda_function" {
  byte_length = 4
}

resource "aws_cloudwatch_log_group" "build_lambda_function" {
  name              = "/codebuild/codebuild-letsencrypt-certs-aws-${random_id.logs_build_lambda_function.hex}${var.suffix}"
  retention_in_days = 7
}

resource "random_id" "logs_build_lambda_function" {
  byte_length = 4
}

resource "random_id" "policy_build_lambda_function" {
  byte_length = 4
}

resource "aws_iam_policy" "build_lambda_function" {
  name        = "codebuild-letsencrypt-certs-aws-${random_id.policy_build_lambda_function.hex}${var.suffix}"
  path        = "/"
  description = "CodeBuild policy for building the letsencrypt-certs-aws Lambda function."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "lambda:CreateFunction",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:${var.partition}:lambda:${var.region}:${var.account_id}:function:${var.lambda_function_name}",
        "${aws_cloudwatch_log_group.build_lambda_function.arn}",
        "${aws_cloudwatch_log_group.build_lambda_function.arn}:log-stream:*"
      ]
    }     
  ]
}
EOF
}
