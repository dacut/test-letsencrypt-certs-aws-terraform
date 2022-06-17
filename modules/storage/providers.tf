terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.3"
    }
  }
}
