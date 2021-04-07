resource "aws_glue_catalog_database" "glue_database_platform" {
  name = "database_platform"
}

resource "aws_glue_catalog_table" "glue_table_cleaned" {
  name          = "cleaned"
  database_name = aws_glue_catalog_database.glue_database_platform.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "parquet.compression" = "UNCOMPRESSED"
    "classification"      = "csv"
  }

  storage_descriptor {
    location      = "s3://cleaned-bucket-platform/processing-sucess"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "ser_platform"
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"

      parameters = {
        "serialization.format" = 1
      }
    }

    columns {
      name = "id"
      type = "string"
    }

    columns {
      name = "name"
      type = "string"
    }

    columns {
      name    = "abv"
      type    = "string"
    }

    columns {
      name    = "ibu"
      type    = "string"
    }

    columns {
      name    = "target_fg"
      type    = "string"
    }

    columns {
      name    = "target_og"
      type    = "string"
    }

    columns {
      name    = "ebc"
      type    = "string"
    }

    columns {
      name    = "srm"
      type    = "string"
    }

    columns {
      name    = "ph"
      type    = "string"
    }

  }
}