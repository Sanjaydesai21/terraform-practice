resource "random_id" "new_id" {
  byte_length = 6
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "work-bucket-${terraform.workspace}-${random_id.new_id.hex}"
}
