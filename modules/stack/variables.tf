variable "account_id" {
  type        = string
  description = "The AWS account we expect to be running in."
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to all resources."
  default     = {}
}

variable "region" {
  type        = string
  description = "The AWS region to provision most resources in."
}

variable "suffix" {
  type        = string
  description = "The suffix to use for all resources."
  default     = ""
}
