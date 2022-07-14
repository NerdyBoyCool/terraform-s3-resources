# AWS S3 Module
S3と一緒に作成されるリソース群を作成するモジュールです。

## 使い方

```hcl
module "s3_bucket" {
  source      = "../../../../modules/s3/"
  bucket_name = "sample-sample"
  logging_configuration = {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "path"
  }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

```


### Encryption By KMS

```hcl
module "s3_bucket" {
  source      = "../../../../modules/s3/"
  bucket_name = "sample-sample"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "aws:kms"
        kms_master_key_id = aws_kms_key.key.id
      }
    }
  }
}

```

### No Encryption

```hcl
module "s3_bucket" {
  source      = "../../../../modules/s3/"
  bucket_name = "sample-sample"
  logging_configuration = {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "path"
  }
}
```



### No Logging Configuration Bucket

```hcl
module "s3_bucket" {
  source      = "../../../../modules/s3/"
  bucket_name = "sample-sample"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

```

### Setting flag variable
- enable_versioning: [バージョンニング](https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/Versioning.html) を有効にするかどうか
- enable_lifecycle_configuration: [ライフサイクル](https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/object-lifecycle-mgmt.html) を有効にするかどうか


## 作成されるリソース

- [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [aws_s3_bucket_logging](https://registry.terraform.io/providers/hashicorp/aws%20%20/latest/docs/resources/s3_bucket_logging)
- [aws_s3_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws%20%20/latest/docs/resources/s3_bucket_versioning)
- [aws_s3_bucket_lifecycle_configuration](https://registry.terraform.io/providers/hashicorp/aws%20%20/latest/docs/resources/s3_bucket_lifecycle_configuration)
- [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)
- [aws_s3_bucket_server_side_encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws%20%20/latest/docs/resources/s3_bucket_server_side_encryption_configuration)

## Outputs
- s3_bucket_id
- s3_bucket_arn
- s3_bucket_region
