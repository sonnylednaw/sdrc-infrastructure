terraform {
  backend "s3" {
    bucket         = "sdrc-terraform-state-bucket"
    key            = "lambda/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    use_lockfile   = true
  }
}