# Terraform GCP Consul Helm

This code uses Terraform to deploy a Consul Enterprise Cluster using a GCP K8s cluster.

It will not setup the K8s cluster, you have to provide it yourself.

It can also setup a secondary Consul Cluster and connect it via Mesh Gateways.

This requires a secondary K8s cluster with the Consul Federation secrets imported into it.

## Consul License

The code deploys Consul Enterprise, so it requires a Consul license.

## Consul Federation

To stand up a secondary Consul cluster, you first need to export the configuration from the primary cluster and import it to the secondary. The code doesn't do this automatically.

The easiest way to do this, is from the built-in cloud shell in GCP. 

1. Login to the GCP console
2. Select the Kubernetes Engine from the GCP console
3. Navigate to the Clusters page
4. For each cluster, select "connect" from the ellipsis menu (see image below)

![](assets/gcp_cluster_connect.png)

Once you're done, you can verify that you have all the contexts configured with this command:

```shell
kubectl config get-contexts
```

Now you can use these commands to export the Consul Federations secrets from the primary cluster and then import them in to the secondary one.

```shell
kubectl config use-context <PRIMARY_CLUSTER_CONTEXT>
kubectl get secret hashicorp-consul-federation -o yaml > consul-federation-secret.yaml
kubectl config use-context <SECONDARY_CLUSTER_CONTEXT>
kubectl apply -f consul-federation-secret.yaml
```

Replace `<PRIMARY_CLUSTER_CONTEXT>` and `<SECONDARY_CLUSTER_CONTEXT>` above with the context name of your primary and secondary clusters respectively.

For more info, see the [documentation](https://www.consul.io/docs/k8s/installation/multi-cluster/kubernetes#federation-secret)
