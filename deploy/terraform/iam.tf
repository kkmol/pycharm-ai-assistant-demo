resource "aws_iam_role" "default" {
  name        = "${var.function_name}-role"
  description = "IAM Execution Role for ${var.function_name} Lambda image"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy.json

  inline_policy {
    name   = "${var.function_name}-extra-perms"
    policy = data.aws_iam_policy_document.lambda_policy.json
  }
}


data "aws_iam_policy_document" "lambda_assume_policy" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy" {
  // edit statements within this policy to allow lambda access to what it requires
  version = "2012-10-17"

  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${local.s3_bucket}",
      "arn:aws:s3:::${local.s3_bucket}/*"
    ]
  }

  // cloudwatch logging, dont remove this section please
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    effect    = "Allow"
    resources = ["${aws_cloudwatch_log_group.default.arn}:*"]
  }
}
