variable "region" {
  type        = string
  description = "GCP region"
}

variable "role" {
  type        = string
  description = "Consult cluster role (primary/secondary)"
  validation {
    condition     = var.role == "primary" || var.role == "secondary"
    error_message = "The role value must be one of 'primary' or 'secondary'."
  }
}

variable "cluster_name" {
  type        = string
  description = "k8s cluster name"
}

variable "consul_license" {
  type        = string
  description = "Consul Enterprice license file contents"
  sensitive   = true
}

variable "project_id" {
  type = string
  description = "GCP project ID"
}

variable "consul_image" {
  type = string
  description = "Consul Enterprise Docker image to use"
  default = "hashicorp/consul-enterprise:latest"
}
