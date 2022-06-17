provider "aws" {
  alias               = "aws"
  allowed_account_ids = [var.account_id]
  region              = var.region
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias               = "aws.use1"
  allowed_account_ids = [var.account_id]
  region              = "us-east-1"
  default_tags {
    tags = var.default_tags
  }
}

provider "random" {}

data "aws_partition" "current" {
  provider = aws
}

resource "random_id" "lambda_function_name" {
  byte_length = 4
}

locals {
  lambda_function_name = "test-letsencrypt-certs-aws-${random_id.lambda_function_name.hex}${var.suffix}"
}
