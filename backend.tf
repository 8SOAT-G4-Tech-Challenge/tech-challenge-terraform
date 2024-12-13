terraform {
  backend "s3" {
    bucket = "tech-challenge-bucket-state-tf"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
		encrypt = true
  }
}