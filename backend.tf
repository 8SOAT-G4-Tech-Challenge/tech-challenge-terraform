terraform {
  backend "s3" {
    bucket = "tech-challenge-terraform"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}