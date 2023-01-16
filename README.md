## Enabling Intel GPU SR-IOV and demo workload on Kubernetes

### Prerequisite
1. Kubernetes Cluster has been successfully setup and run
2. Install terraform tool (https://developer.hashicorp.com/terraform/downloads)
3. Install Helm tol (https://helm.sh/docs/intro/quickstart/)
4. Host OS with Intel GPU SR-IOV patches (please contact author if you need help)


### Configuration
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

### Deploy GPU SR-IOV setting and benchmarking workload on K8s 
1. Initiziate Terraform project (only for first time):
```
cd /data/synbench/k8s/terraform
terraform init    
```

2. Validation (everytime changes has been made)
```
terraform plan -var-file="secret.tfvars"     
```

3. Deloyment (everytime changes has been made)
```
terraform apply --auto-approve -var-file="secret.tfvars"   
```

4. Remove the deployment 
```
terraform destroy --auto-approve -var-file="secret.tfvars"   
```

### Configuring execution time and timeout on individual SR-IOV Virtual GPU

1. Open "variables.tf" file, and search for "gpu_sriov_config"
2. Change "exec" and "timeout" values according to user requirement (default setting is 0)
```
...
variable "gpu_sriov_config" {
  default = [
              {id="1",exec=25000,timeout=50000},
              {id="2",exec=25001,timeout=30001},
              {id="3",exec=25,timeout=20},
              {id="4",exec=26,timeout=20},
              {id="5",exec=27,timeout=20},
              {id="6",exec=28,timeout=20},
              {id="7",exec=29,timeout=20}
            ]

}

```
3. Save the file
4. Re-run Terraform task as stated in previous section of this document
