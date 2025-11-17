resource "aws_s3_bucket" "static_assets" {
  bucket = "nextjs-static-assets-prod"
  tags = {
    Name = "nextjs-static-assets"
    Environment = "production"
  }
}

resource "aws_s3_bucket_versioning" "static_assets_versioning" {
  bucket = aws_s3_bucket.static_assets.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "static_assets_encryption" {
  bucket = aws_s3_bucket.static_assets.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
