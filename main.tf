# main.tf

resource "null_resource" "foo" {
  triggers = {
    foo = var.project
  }
}

resource "aws_s3_bucket" "bucket-foo_uF9A7ZyZQBXMFqru" {
  bucket = "bucket-foo"
}

resource "aws_s3_bucket_public_access_block" "bucket-foo_uF9A7ZyZQBXMFqru" {
  bucket                  = aws_s3_bucket.bucket-foo_uF9A7ZyZQBXMFqru.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "bucket-foo_uF9A7ZyZQBXMFqru" {
  bucket = aws_s3_bucket.bucket-foo_uF9A7ZyZQBXMFqru.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "bucket-foo_uF9A7ZyZQBXMFqru" {
  bucket = aws_s3_bucket.bucket-foo_uF9A7ZyZQBXMFqru.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-foo_uF9A7ZyZQBXMFqru" {
  bucket = aws_s3_bucket.bucket-foo_uF9A7ZyZQBXMFqru.id

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    filter {
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  rule {
    id     = "abort-multipart-upload"
    status = "Enabled"

    filter {
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
