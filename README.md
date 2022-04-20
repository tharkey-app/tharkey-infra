# Infrastructure for Tharkey app

## Prerequisites
- Terraform
- Kubectl

## Deploy the infrastructure

```
set ARM_CLIENT_ID=...
set ARM_CLIENT_SECRET=...
set ARM_SUBSCRIPTION_ID=...
set ARM_TENANT_ID=...

terraform apply

set KUBECONFIG=kubeconfig
kubectl get nodes
```

```
terraform destroy
```

