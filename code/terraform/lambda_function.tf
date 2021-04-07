resource "aws_lambda_function" "lambda_data_processing" {
  filename      = "lambda_data_processing.zip"
  function_name = "lambda_data_processing"
  role          = aws_iam_role.aws_iam_platform_role.arn
  handler       = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("lambda_data_processing.zip")
  runtime = "python3.6"
}

resource "aws_lambda_function" "lambda_data_transformation" {
  filename      = "lambda_data_transformation.zip"
  function_name = "lambda_data_transformation"
  role          = aws_iam_role.aws_iam_platform_role.arn
  handler       = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("lambda_data_transformation.zip")
  runtime = "python3.6"
}

resource "aws_lambda_function" "lambda_call_endpoint" {
  filename      = "lambda_call_endpoint.zip"
  function_name = "lambda_call_endpoint"
  role          = aws_iam_role.aws_iam_platform_role.arn
  handler       = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("lambda_call_endpoint.zip")
  runtime = "python3.6"
}