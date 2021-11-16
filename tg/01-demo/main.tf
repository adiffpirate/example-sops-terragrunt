terraform {
  backend "kubernetes" {
    secret_suffix    = "age-demo"
    load_config_file = true
  }
}

output "db_user" {
  value = var.db_user
  sensitive = true
}

output "db_pass" {
  value = var.db_pass
  sensitive = true
}

output "project" {
  value = var.project
}

output "env" {
  value = var.env
}
