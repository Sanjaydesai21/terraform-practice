resource "aws_s3_bucket" "s3" {
  bucket = "bucket-for-prevent-destroy"
  tags = {
    Name = "bucket-for-prevent-destroy"
  }

  lifecycle {
    prevent_destroy = true
  }
}
