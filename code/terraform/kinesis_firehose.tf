resource "aws_kinesis_firehose_delivery_stream" "raw_delivery_stream" {
  name        = "kinesis_firehose_raw_s3"
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.kinesis_stream.arn
    role_arn = aws_iam_role.aws_iam_platform_role.arn
  }
  s3_configuration {
    role_arn   = aws_iam_role.aws_iam_platform_role.arn
    bucket_arn = aws_s3_bucket.raw_bucket.arn
  }
}

resource "aws_kinesis_firehose_delivery_stream" "cleaned_delivery_stream" {
  name        = "kinesis_firehose_cleaned_s3"
  destination = "extended_s3"
  
  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.kinesis_stream.arn
    role_arn = aws_iam_role.aws_iam_platform_role.arn
  }
  extended_s3_configuration {
    buffer_size = 64
    role_arn   = aws_iam_role.aws_iam_platform_role.arn
    bucket_arn = aws_s3_bucket.clean_bucket.arn

    # ... other configuration ...
    data_format_conversion_configuration {
      input_format_configuration {
        deserializer {
          open_x_json_ser_de {}
        }
      }

      output_format_configuration {
        serializer {
          parquet_ser_de {}
        }
      }

      schema_configuration {
        database_name = aws_glue_catalog_database.glue_database_platform.name
        role_arn      = aws_iam_role.aws_iam_platform_role.arn
        table_name    = aws_glue_catalog_table.glue_table_cleaned.name
      }
    }

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.lambda_data_transformation.arn}:$LATEST"
        }
      }
    }
  }
}