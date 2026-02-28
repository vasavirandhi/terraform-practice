terraform {
  backend "s3" {
    bucket         = "vasavi-terraform-state-bucket-2026"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}