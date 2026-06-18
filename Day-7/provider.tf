provider "aws" {
  region  = "ap-south-1"
  profile = "config"
}

terraform {
  backend "s3" {
    bucket                   = module.s3-bucket.s3_bucket_name
    region                   = "ap-south-1"
    key                      = "terraform.tfstate"
    use_lockfile             = true
    profile                  = "config"
    shared_credentials_files = ["/root/.aws/credentials"]
  }
}
