resource "aws_iam_role" "lambda-exec-role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambda-exec-role-policy" {
  name = "iq-processor-policy"
  role = aws_iam_role.lambda-exec-role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::sigMF-bucket/*",
          "*"
        ]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricData",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:DescribeAlarms"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "iq-processor" {
  function_name = "sigMF-s3-processor"
  role          = aws_iam_role.lambda-exec-role.arn
  package_type = "Image"
  reserved_concurrent_executions = var.sdr-node-count
  timeout = 30
  image_uri     = "${aws_ecr_repository.iq-lambda-processor-image.repository_url}:${var.lambda_image_tag}"
}