data "aws_partition" "current" {
  provider = aws
}

resource "random_id" "lambda_function_name" {
  byte_length = 4
}

locals {
  lambda_function_name = "test-letsencrypt-certs-aws-${random_id.lambda_function_name.hex}${var.suffix}"
}
