variable "bucket_name" {
  type = string
}

variable "logging_configuration" {
  type    = map(string)
  default = {}
}

variable "enable_versioning" {
  type    = bool
  default = true
}

variable "enable_lifecycle_configuration" {
  type    = bool
  default = true
}

variable "s3_noncurrent_version_expiration_days" {
  type        = number
  description = "S3 の過去バージョンが削除されるまでの日数"
}

variable "server_side_encryption_configuration" {
  type    = any
  default = {}
}
