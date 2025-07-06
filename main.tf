provider "aws" {
  region  = "eu-north-1"
  profile = "dev-user"
}


variable "lambda_image_tag" {
  description = "Tag for the Lambda Docker image"
  type        = string
  default     = "latest"
}

variable "sdr-node-count" {
  description = "Number of reserved concurrency lambdas for SDR nodes."
  type = number
  default = 1
}