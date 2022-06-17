terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.12"
      configuration_aliases = [aws, aws.use1]
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.3"
    }
  }
}
