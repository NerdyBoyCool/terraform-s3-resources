resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_logging" "bucket_logging" {
  count         = length(keys(var.logging_configuration)) > 0 ? 1 : 0
  bucket        = aws_s3_bucket.bucket.id
  target_bucket = var.logging_configuration["target_bucket"]
  target_prefix = var.logging_configuration["target_prefix"]
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count = var.enable_versioning ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle_configuration" {
  count  = var.enable_lifecycle_configuration ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "bucket_lifecycle"
    status = "Enabled"
    transition {
      days          = 0
      storage_class = "INTELLIGENT_TIERING"
    }
    noncurrent_version_expiration {
      noncurrent_days = var.s3_noncurrent_version_expiration_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_server_side_encryption_configuration" {
  count = length(keys(var.server_side_encryption_configuration)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  dynamic "rule" {
    for_each = try(flatten([var.server_side_encryption_configuration["rule"]]), [])

    content {
      dynamic "apply_server_side_encryption_by_default" {
        for_each = try([rule.value.apply_server_side_encryption_by_default], [])

        content {
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
          kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
        }
      }
    }
  }
}
