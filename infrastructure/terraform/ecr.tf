resource "aws_ecr_repository" "cbc_data_pipeline" {
  name                 = "cbc-data-pipeline"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project     = "cbc-data-pipeline"
    Environment = var.environment
  }
}
