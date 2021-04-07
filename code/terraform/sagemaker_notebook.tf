resource "aws_sagemaker_code_repository" "sagemaker-model-repository" {
  code_repository_name = "sagemaker-model-repository"

  git_config {
    repository_url = "https://github.com/ldynczuki/MLPlatformEngineer"
  }
}

resource "aws_sagemaker_notebook_instance" "sagemaker-model" {
  name                    = "sagemaker-model"
  role_arn                = aws_iam_role.aws_iam_platform_role.arn
  instance_type           = "ml.t2.medium"
  default_code_repository = aws_sagemaker_code_repository.sagemaker-model-repository.code_repository_name
}