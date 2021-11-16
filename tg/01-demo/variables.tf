variable "project" {}
variable "env" {}

variable "db_user" {
  sensitive = true
}

variable "db_pass" {
  sensitive = true
}
