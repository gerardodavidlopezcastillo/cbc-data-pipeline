# Definimos el proveedor de AWS y la versión
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Fuente proveedor
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "gdlopezcastillo-cbc"
}
