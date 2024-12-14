terraform {
  backend "s3" {
    bucket = "tech-challenge-terraform-state"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
		encrypt = true
  }
}