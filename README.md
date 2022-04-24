# Infrastructure for Tharkey app

## Prerequisites
- Terraform
- Kubectl

## Deploy the infrastructure

```
set SCW_ACCESS_KEY=...
set SCW_SECRET_KEY=...

cd roots\tharkey-infra-static
terraform init
terraform apply
cd ..\..

cd roots\tharkey-infra-core
terraform init
terraform apply
cd ..\..

set KUBECONFIG=kubeconfig
kubectl get nodes

cd roots\tharkey-infra-compute
terraform init
terraform apply
cd ..\..

kubectl apply -f test.yml
```

```
cd roots\tharkey-infra-compute
terraform destroy
cd ..\..

cd roots\tharkey-infra-core
terraform destroy
cd ..\..
```

