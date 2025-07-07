variable "lambda_image_tag" {
  type    = string
  default = "v0.0.1"
}


variable "sdr-node-count" {
  description = "Number of reserved concurrency lambdas for SDR nodes."
  type = number
  default = 1
}