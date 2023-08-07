# terraform {
#   backend "s3" {
#     bucket = "zuto-terraform-state-files"
#     key    = "lambda/lambda-python-template/lambda-python-template.tfstate"
#     region = "eu-west-2"
#     acl    = "bucket-owner-full-control"
#   }
# }
