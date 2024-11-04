variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resources"
}

variable "api_gateway" {
  type        = string
  description = "Name of api gateway"
}

variable "stage_name" {
  type        = string
  description = "Name of stage name"
}

variable "function_name" {
  type        = string
  description = "Name of function name"
}

variable "lambda_role_name" {
  type        = string
  description = "Name of the Lambda role for TID routing logic role"
}


