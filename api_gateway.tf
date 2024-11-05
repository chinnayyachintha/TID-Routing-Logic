# API Gateway Setup (Trigger for the Lambda)
resource "aws_api_gateway_rest_api" "tid_routing_api" {
  name        = "${var.function_name}_api"
  description = "API Gateway to trigger the TID Routing Lambda function"
}

# API Gateway Resource
resource "aws_api_gateway_resource" "routing_resource" {
  rest_api_id = aws_api_gateway_rest_api.tid_routing_api.id
  parent_id   = aws_api_gateway_rest_api.tid_routing_api.root_resource_id
  path_part   = "route"
}

# API Gateway Method
resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.tid_routing_api.id
  resource_id   = aws_api_gateway_resource.routing_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integrate API Gateway with Lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tid_routing_api.id
  resource_id             = aws_api_gateway_resource.routing_resource.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.tid_routing_lambda.invoke_arn
}

# Permission to allow API Gateway to invoke Lambda
resource "aws_lambda_permission" "allow_apigateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tid_routing_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.tid_routing_api.execution_arn}/*/*"
}

# Deployment for API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.tid_routing_api.id
  depends_on  = [aws_api_gateway_integration.lambda_integration] # Ensures the integration is complete before deployment
}

# Define the stage for API Gateway
resource "aws_api_gateway_stage" "api_stage" {
  rest_api_id   = aws_api_gateway_rest_api.tid_routing_api.id
  stage_name    = "${var.stage_name}" 
  deployment_id = aws_api_gateway_deployment.api_deployment.id
}
