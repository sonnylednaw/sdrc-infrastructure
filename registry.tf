resource "aws_ecr_repository" "iq-lambda-processor-image" {
  name = "iq-lambda-processor"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.iq-lambda-processor-image.repository_url
  description = "The URL of the ECR repository for Docker images."
}