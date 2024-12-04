variable "account_id_voclabs" {
}

variable "tech-challenge-cluster" {
  default = "tech-challenge-cluster"
}

variable "vpcCidr" {
  default = "172.31.0.0/16"
}

variable "tech_challenge_project_name" {
  description = "The name of the project"
  type        = string
}

variable "region_default" {
  description = "The default region"
  type        = string
}

