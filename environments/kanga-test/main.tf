module "stack" {
  source       = "../../modules/stack"
  account_id   = local.account_id
  default_tags = local.default_tags
  region       = local.region

  providers = {
    aws      = aws
    aws.use1 = aws.use1
    random   = random
  }
}

provider "aws" {
  allowed_account_ids = [local.account_id]
  region              = local.region
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias               = "use1"
  allowed_account_ids = [local.account_id]
  region              = "us-east-1"
  default_tags {
    tags = local.default_tags
  }
}

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
