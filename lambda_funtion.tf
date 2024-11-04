# Zip the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda/lambda_function.py"
  output_path = "lambda/lambda_function.zip"
}

# Lambda Function
resource "aws_lambda_function" "tid_routing_lambda" {
  function_name    = var.function_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

  # Environment variables (optional)
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}

