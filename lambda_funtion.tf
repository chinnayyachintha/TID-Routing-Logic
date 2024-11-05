# Zip the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda/lambda_function.py"  # Ensure this path is correct
  output_path = "lambda/lambda_function.zip" # Ensure this is writable
}

# Define the Lambda function
resource "aws_lambda_function" "tid_routing_lambda" {
  function_name    = var.function_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler" # Ensure this matches your function's handler
  runtime          = "python3.9"                      # Update if using a different version
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

  # Environment variables
  environment {
    variables = {
      TERMINAL_ID_CAD_DIRECT   = "0017340008025557375191"
      TERMINAL_ID_CAD_INDIRECT = "0089250008025557441121"
      TERMINAL_ID_USD_DIRECT   = "0017340008025557391040"
      TERMINAL_ID_USD_INDIRECT = "0089250008025557433284"
      LOG_LEVEL                = "INFO"
    }
  }
}