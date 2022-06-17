resource "random_id" "test_resources" {
  byte_length = 4
}

resource "aws_s3_bucket" "test_resources" {
  bucket              = "test-letsencrypt-certs-aws-${random_id.test_resources.hex}${var.suffix}"
  force_destroy       = true
  object_lock_enabled = false
}

resource "aws_s3_bucket_lifecycle_configuration" "test_resources" {
  bucket = aws_s3_bucket.test_resources.bucket
  rule {
    id     = "Delete test resources"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 2
    }

    expiration {
      expired_object_delete_marker = true
    }

    noncurrent_version_expiration {
      noncurrent_days = 14
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "test_resources" {
  bucket = aws_s3_bucket.test_resources.bucket

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "test_resources" {
  bucket = aws_s3_bucket.test_resources.bucket
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSSLRequestsOnly",
      "Effect": "Deny",
      "Action": "s3:*",
      "Resource": [
        "arn:${var.partition}:s3:::${aws_s3_bucket.test_resources.bucket}",
        "arn:${var.partition}:s3:::${aws_s3_bucket.test_resources.bucket}/*"
      ],
      "Principal": "*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": ["false"]
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "test_resources" {
  bucket                  = aws_s3_bucket.test_resources.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "test_resources" {
  bucket = aws_s3_bucket.test_resources.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
