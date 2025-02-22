# S3 bucket for backups
resource "aws_s3_bucket" "baru_backup_bucket" {
  bucket = "webapp-bucket1"
  tags = {
    Name        = "webapp-bucket1"
    Environment = "Production"
  }

  # Allows deletion of non-empty bucket
  force_destroy = true 

  # Avoid error S3:GetObjectLockConfig because lack of IAM roles
  object_lock_enabled = false 

}

resource "aws_s3_bucket_versioning" "backup_bucket_versioning" {
  bucket = aws_s3_bucket.baru_backup_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backup_bucket_encryption" {
  bucket = aws_s3_bucket.baru_backup_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
