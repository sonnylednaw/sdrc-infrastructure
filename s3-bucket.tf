resource "aws_s3_bucket" "sigMF-bucket" {
  bucket = "sigmf-bucket"

  tags = {
    Name        = "sigmf-bucket"
    Environment = "Dev"
  }
}
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.iq-processor.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.sigMF-bucket.arn
}

resource "aws_s3_bucket_notification" "s3-lambda-trigger" {
  bucket = aws_s3_bucket.sigMF-bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.iq-processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [
    aws_lambda_permission.allow_s3,
    aws_lambda_function.iq-processor
  ]
}


output "sigMF_bucket_url" {
  value       = aws_s3_bucket.sigMF-bucket.bucket_regional_domain_name
  description = "The URL of the sigMF S3 bucket."
}