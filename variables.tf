variable "account_id_voclabs" {
}
variable "tech-challenge-cluster" {
  default = "tech-challenge-cluster"
}
variable "vpc_cidr" {
  default = "192.168.0.0/16"
}
variable "project_name" {
  description = "The name of the project"
  type        = string
}
variable "region_default" {
  description = "The default region"
  type        = string
}
variable "admin_user_email" {
  description = "The email of the admin user"
  type        = string
}
variable "admin_user_password" {
  description = "The password of the admin user"
  type        = string
}
