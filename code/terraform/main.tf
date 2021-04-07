terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Retirar as credenciais antes de subir pro git
provider "aws" {
    # region = "sa-east-1"
    region = "us-east-2"
    # access_key = "AKIA3RRF77IFT2ETWOPC"
    # secret_key = "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"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}