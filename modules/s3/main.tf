resource "aws_s3_bucket" "s3_bkt" {
  bucket = "s3-vulnerable-lab-forensic"
  tags = {
    Name = "s3-vulnerable-lab-forensic"
  }
}

resource "aws_s3_object" "object-flag" {
  bucket = aws_s3_bucket.s3_bkt.id
  key = "flag.txt"
  source = "${path.module}/files/flag.txt"
  etag = filemd5("${path.module}/files/flag.txt")
}