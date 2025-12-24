resource "aws_s3_bucket" "main" {
  bucket = "my-terraform-bucket-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "Main S3 Bucket"
    Environment = "dev"
    ManagedBy = "terraform"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
