resource "aws_api_gateway_rest_api" "api_platform_sagemaker" {
  name = "api_platform_sagemaker"
  description = "API que realiza a chamada em uma função lambda para executar a inferência de um modelo de regressão linear."
  
  endpoint_configuration {
   types = ["REGIONAL"]
  }

}

resource "aws_api_gateway_resource" "api_resources" {
  rest_api_id = aws_api_gateway_rest_api.api_platform_sagemaker.id
  parent_id   = aws_api_gateway_rest_api.api_platform_sagemaker.root_resource_id
  path_part   = "resources"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api_platform_sagemaker.id
  resource_id   = aws_api_gateway_resource.api_resources.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "response_200" {
    rest_api_id = aws_api_gateway_rest_api.api_platform_sagemaker.id
    resource_id = aws_api_gateway_resource.api_resources.id
    http_method = aws_api_gateway_method.method.http_method
    status_code = "200"

    response_models = {
         "application/json" = "Empty"
    }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_platform_sagemaker.id
  resource_id             = aws_api_gateway_resource.api_resources.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda_call_endpoint.invoke_arn
}

resource "aws_api_gateway_integration_response" "api_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api_platform_sagemaker.id
  resource_id = aws_api_gateway_resource.api_resources.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = <<EOF
#set($allParams = $input.params())
{
"body-json" : $input.json('$')
}
EOF
  }
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_platform_sagemaker.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api_resources.id,
      aws_api_gateway_method.method.id,
      aws_api_gateway_integration.integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "call_lambda" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_platform_sagemaker.id
  stage_name    = "call_lambda"
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_call_endpoint.arn
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.api_platform_sagemaker.execution_arn}/*/*/*"
}