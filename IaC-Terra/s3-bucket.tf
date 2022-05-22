terraform {
    #Configure For Backend as S3 
  backend "s3" {
    bucket         = "s3_state1"
    key            = "global/s3/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
  }
}


# Create S3 Bucket 

resource "aws_s3_bucket" "s3_state1" {
  bucket = "example-bucket"
}
  # Enable versioning so we can see the full revision history of our
  # state files
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_state1.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3_state1.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}
