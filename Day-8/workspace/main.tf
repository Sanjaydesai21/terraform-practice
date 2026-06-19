resource "random_id" "new_id" {
  byte_length = 6
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "work_bucket_${terraform.workspace}_${random_id.new_id.hex}"
}
