variable "account_id" {
  type        = string
  description = "The AWS account we expect to be running in."
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function to create."
}

variable "partition" {
  type        = string
  description = "The AWS partition being used."
}

variable "region" {
  type        = string
  description = "The AWS region to provision most resources in."
}

variable "suffix" {
  type        = string
  description = "The suffix to use for all resources."
}
