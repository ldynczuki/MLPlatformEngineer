resource "aws_s3_bucket" "raw_bucket" {
  bucket = "raw-bucket-platform"
  acl    = "private"
}

resource "aws_s3_bucket" "clean_bucket" {
  bucket = "cleaned-bucket-platform"
  acl    = "private"
}

# Criando esse bucket S3 para armazenar consultas via Athena no Glue
resource "aws_s3_bucket" "query_bucket" {
  bucket = "query-bucket-platform"
  acl    = "private"
}