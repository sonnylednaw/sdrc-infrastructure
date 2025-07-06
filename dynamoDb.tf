resource "aws_dynamodb_table" "measurement-analysis-results" {
  name           = "MeasurementAnalysisResults"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "ResultId"
  range_key      = "OperationId"

  attribute {
    name = "ResultId"
    type = "S"
  }

  attribute {
    name = "OperationId"
    type = "S"
  }

  attribute {
    name = "NodeId"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  global_secondary_index {
    name               = "ResultIdNodeIdIndex"
    hash_key           = "ResultId"
    range_key          = "NodeId"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["ALL"]
  }

  tags = {
    Name        = "MeasurementAnalysisResults-table-1"
    Environment = "dev"
  }
}