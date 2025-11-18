terraform {
  backend "s3" {
    bucket         = "gvrdc-terraform-state"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gvrdc-terraform-locks"
    encrypt        = true
  }
}
