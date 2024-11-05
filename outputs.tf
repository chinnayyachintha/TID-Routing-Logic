# Output the API Gateway endpoint URL for invoking the Lambda function
output "api_gateway_url" {
  description = "The URL to invoke the TID Routing Lambda function via API Gateway"
  value       = "${aws_api_gateway_rest_api.tid_routing_api.execution_arn}/${aws_api_gateway_stage.api_stage.stage_name}/route"
}

# Output the Lambda function name
output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.tid_routing_lambda.function_name
}

# Output the Lambda function ARN
output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.tid_routing_lambda.arn
}

# Output the API Gateway ID
output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.tid_routing_api.id
}

# Output the HTTP method for the API Gateway method
output "http_method_value" {
  description = "The HTTP method used by the API Gateway method"
  value       = aws_api_gateway_method.post_method.http_method
}
