locals {
  account_id = "557925715019"
  region     = "us-west-2"
  default_tags = {
    "Project"   = "letencrypt-aws-certs"
    "Terraform" = "github.com/dacut/test-letsencrypt-certs-aws/envrionments/kanga-test"
  }
}

terraform {
  backend "s3" {
    # The region where the Terraform state is stored.
    region = "us-west-2"

    # The S3 bucket where the Terraform state is stored.
    bucket = "kanga-terraform-state"

    # The S3 key where your Terraform state is stored.
    key = "test-letsencrypt-certs-aws.tfstate"

    # The DynamoDB table to use for locking Terraform actions.
    dynamodb_table = "Terraform-Lock"
  }
}
