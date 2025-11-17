resource "aws_s3_bucket" "main" {
  bucket = "main"
  tags = {
    Name = "main"
    ManagedBy = "Kyrna"
  }
}
