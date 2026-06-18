resource "aws_s3_bucket" "terraform-tfstate-lock-check" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
  }

}
