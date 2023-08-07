resource "aws_lambda_function" "default" {
  function_name = var.function_name
  role          = aws_iam_role.default.arn

  description = var.function_description

  package_type = "Image"
  image_uri    = "${var.ecr_repository}/${var.function_name}:${var.service_version}"


  timeout     = var.function_timeout # seconds
  memory_size = var.function_memory  # MB


  environment {
    variables = {
      // dont remove the ENVIRONMENT, put any new below it
      ENVIRONMENT = terraform.workspace
      // put any extra environment variables here, but if they need constructing, do it in locals
      S3_BUCKET_NAME = local.s3_bucket

    }
  }
}
