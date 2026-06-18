output "alb_dns" {
  value = module.alb.alb_dns
}

output "s3_bucket_name" {
  value = module.s3_bucket.bucket_name
}
