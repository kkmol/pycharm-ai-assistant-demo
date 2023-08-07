locals {
  common_tags = {
    environment = terraform.workspace
    lifecycle   = "example"
    owner       = "Data Squad"
  }

  // if lambda environment variables need constructing, it should be here
  s3_bucket = "${var.s3_bucket_prefix}-${terraform.workspace}"
}
