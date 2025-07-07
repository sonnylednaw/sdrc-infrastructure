resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "sdrc-terraform-state-bucket"
  force_destroy = true

  tags = {
    Name        = "terraform-state"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "tf_state_lock" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-locks"
    Environment = "Dev"
  }
}
