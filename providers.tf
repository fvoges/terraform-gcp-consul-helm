terraform {
  # backend "remote" {
  #   organization = "hc-implementation-services"

  #   workspaces {
  #     name = "arvato-gcp-k8s-consul-primary"
  #   }
  # }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = "${var.region}-a"
}

data "google_client_config" "default" {}

data "google_container_cluster" "default" {
  name = var.cluster_name
  location = var.region
}

provider "kubernetes" {
  load_config_file = false
  host             = "https://${data.google_container_cluster.default.endpoint}"
  token            = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.default.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
    )
  }
}
