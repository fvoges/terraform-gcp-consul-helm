resource "random_id" "consul_gossip_encryption_key" {
  byte_length = 32
}

resource "kubernetes_secret" "consul_ent_license" {
  metadata {
    name = "consul-ent-license"
  }
  data = {
    key = var.consul_license
  }
}

resource "kubernetes_secret" "consul_gossip_encryption_key" {
  metadata {
    name = "consul-gossip-encryption-key"
  }
  data = {
    key = random_id.consul_gossip_encryption_key.b64_std
  }
}

resource "helm_release" "consul" {
  name       = "hashicorp"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  version    = "0.28.0"

  values = [
    file("config-primary.yaml")
  ]

  depends_on = [
    kubernetes_secret.consul_ent_license,
    kubernetes_secret.consul_gossip_encryption_key,
  ]
}
