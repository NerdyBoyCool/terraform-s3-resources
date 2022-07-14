output "s3_bucket_id" {
  value       = aws_s3_bucket.bucket.id
  description = "The name of the bucket."
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the bucket. ex.) arn:aws:s3:::bucketname."
}

output "s3_bucket_region" {
  value       = aws_s3_bucket.bucket.region
  description = "The AWS region this bucket resides in."
}
