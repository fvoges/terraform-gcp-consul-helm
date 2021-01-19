# Terraform GCP Consul Helm

This code uses Terraform to deploy a Consul Enterprise Cluster using a GCP K8s cluster.

It will not setup the K8s cluster, you have to provide it yourself.

It can also setup a secondary Consul Cluster and connect it via Mesh Gateways.

This requires a secondary K8s cluster with the Consul Federation secrets imported into it.

## Consul License

The code deploys Consul Enterprise, so it requires a Consul license.

