resource "aws_cloudwatch_event_rule" "cloudwatch_event" {
  name = "run_ml_platform"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "cloudwatch_target" {
  rule = aws_cloudwatch_event_rule.cloudwatch_event.name
  arn = aws_lambda_function.lambda_data_processing.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_data_processing.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event.arn
}