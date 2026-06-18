resource "aws_s3_bucket" "terraform-tfstate-lock-check" {
  bucket = "terraform-tfstate-lock-check"
  tags = {
    Name = "terraform-tfstate-lock-check"
  }

}
