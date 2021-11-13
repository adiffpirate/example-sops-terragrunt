terraform {
  required_providers {
    sops = {
      source = "carlpett/sops"
      version = "~> 0.5"
    }
  }
}

data "sops_file" "secrets" {
  source_file = "secrets.yaml"
  input_type  = "yaml"
}

output "db_user" {
  value = data.sops_file.secrets.data.db_user
  sensitive = true
}

output "db_pass" {
  value = data.sops_file.secrets.data.db_pass
  sensitive = true
}

output "project" {
  value = var.project
}

output "env" {
  value = var.env
}

# output "nested-yaml-value" {
#   # Access the password variable that is under db via the terraform object
#   value = yamldecode(data.sops_file.demo-secret.raw).db.password
# }
