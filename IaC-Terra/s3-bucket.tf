# Create S3 Bucket 

backend "s3" {
      bucket = "s3-bucket"
      key = "./terraform.tfstate"
      region = var.aws_region
      dynamodb_table ="backend"
  }