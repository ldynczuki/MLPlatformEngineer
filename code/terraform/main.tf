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
    region = "us-east-2"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}
