locals {
  account_id = "557925715019"
  region     = "us-west-2"
  default_tags = {
    "Project"   = "letencrypt-aws-certs"
    "Terraform" = "github.com/dacut/test-letsencrypt-certs-aws/envrionments/kanga-test"
  }
}

terraform {
  backend "cloud" {
    organization = "Ionosphere"
  }
}
