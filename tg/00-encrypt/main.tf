terraform {
  backend "kubernetes" {
    secret_suffix    = "age-encrypt"
    load_config_file = true
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "encrypt" {
  metadata {
    name = "encrypt"
  }
}

resource "kubernetes_secret" "enc_keys" {
  depends_on = [kubernetes_namespace.encrypt]

  # immutable = true

  metadata {
    name      = "enc-keys"
    namespace = "encrypt"
  }

  data = {
    public-key  = var.public_key
    private-key = var.private_key
  }
}

# resource "local_file" "enc_keys" {
#   sensitive_content = <<EOF
# # public key: ${var.public_key}
# ${var.private_key}
# EOF
#   filename = pathexpand("~/.config/sops/age/keys.txt")
# }

data "kubernetes_secret" "enc_keys" {
  depends_on = [kubernetes_secret.enc_keys]
  metadata {
    name      = "enc-keys"
    namespace = "encrypt"
  }
}

output "public_key" {
  value = data.kubernetes_secret.enc_keys.data.public-key
  sensitive = true
}

output "private_key" {
  value = data.kubernetes_secret.enc_keys.data.private-key
  sensitive = true
}
