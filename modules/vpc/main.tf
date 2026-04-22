resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vulnerable-lab-vpc"
  }
}

resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = aws_s3_bucket.flow_logs_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this.id

  destination_options {
    file_format        = "plain-text"
    per_hour_partition = true     
  }

  tags = {
    Name = "flow-logs-custodia"
  }
}

resource "aws_s3_bucket" "flow_logs_bucket" {
  bucket        = "infra-logs-custodia-imdsv1"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.flow_logs_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.flow_logs_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}