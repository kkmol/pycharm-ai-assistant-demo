variable "service_version" {
  default     = "beta"
  description = "some quirk of the terraform template. Applied in GoCD environment variables"
  type        = string
}

## Function Definition
## Make sure you change these to the current applications name

variable "function_name" {
  default     = "lambda-python-template"
  description = "Name of the Lambda Function & associated resources"
  type        = string
}

variable "function_description" {
  default     = "Example Lambda Image demonstrating how to deploy an Image-based python function"
  description = "Description of the Lambda Function"
  type        = string
}

## Environment Variable Related
## Anything that needs to be put into the Lambda in some way
variable "s3_bucket_prefix" {
  default     = "zuto-datalake-raw"
  description = "Name of S3 bucket without `-prod` or `-qa`"
  type        = string
}


## Static Variables
## You probably dont need to touch these

variable "function_timeout" {
  default     = 30
  description = "Maximum running time of an invocation (seconds)"
  type        = number
}

variable "function_memory" {
  default     = 128
  description = "Memory Allocation (MB-ish)"
  type        = number
}

variable "ecr_repository" {
  default     = "525344447431.dkr.ecr.eu-west-2.amazonaws.com"
  description = "Base ECR Repository on Infrastructure AWS Account"
  type        = string
}
