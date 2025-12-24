resource "aws_s3_bucket" "main_kcgk1" {
  bucket = "main"
  tags = {
    Name = "main"
    ManagedBy = "Kyrna"
  }
}
