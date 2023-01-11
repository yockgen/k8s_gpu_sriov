# Enabling Intel GPU SR-IOV on k8s and demo workload using Terraform

## Prerequisite
1. Kubernetes Cluster has been successfully setup and run
2. Install terraform tool (https://developer.hashicorp.com/terraform/downloads)
3. Install Helm tol (https://helm.sh/docs/intro/quickstart/)
4. Host OS with Intel GPU SR-IOV patches (please contact author if you need help)


## Configuration

1. Create default directory structure
```
mkdir /data
cd /data
git clone https://github.com/yockgen/k8s_gpu_sriov.git /data/synbench
cd /data/synbench/k8s/terraform
```

2. Edit following file with targetted k8s nodes' login and IP addresses
```
root@node1:/data/synbench/k8s/terraform# cat variables.tf
variable "username" {
  description = "Linux username"
  type        = string
  sensitive   = true
  default     = "yockgenm" <---- change to Linux username with sudo privillege
}

...

variable "nodes" {
  default = ["192.168.1.107","192.168.1.111"] <---- change to targetted k8s nodes' IP addresses
}

```
3. Create a login password file named as "secret.tfvars", added line below and change to the correct password of previous step's defined username
```
root@node1:/data/synbench/k8s/terraform# cat secret.tfvars
pwd = "FakePasswordPleaseChange"
```


## Deploy GPU SR-IOV workload K8s cluster
```
terraform init    
terraform plan -var-file="secret.tfvars"     
terraform destroy -var-file="secret.tfvars"   
terraform apply -var-file="secret.tfvars"   
```
