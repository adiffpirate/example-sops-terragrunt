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

resource "kubernetes_secret" "enc_key" {
  depends_on = [kubernetes_namespace.encrypt]

  # immutable = true

  metadata {
    name      = "enc-key"
    namespace = "encrypt"
  }

  data = {
    key = var.key
  }
}

data "kubernetes_secret" "enc_key" {
  depends_on = [kubernetes_secret.enc_key]
  metadata {
    name      = "enc-key"
    namespace = "encrypt"
  }
}

output "key" {
  value = data.kubernetes_secret.enc_key.data.key
  sensitive = true
}
