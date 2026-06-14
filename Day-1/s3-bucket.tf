resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraform-s3-bucket-sanjaydesai"

  tags = {
    Name = "demo bucket"
  }
}

resource "aws_s3_object" "sample_file" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = "sample.txt"
  source = "sample.txt"
  etag   = filemd5("sample.txt")
}
