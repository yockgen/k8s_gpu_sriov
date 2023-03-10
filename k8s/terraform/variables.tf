variable "helm_chart" {
  description = "Synbench Helm Chart Path"
  type        = string
  sensitive   = true
  default     = "/data/synbench/k8s/helm/gpu-sriov"
}

variable "username" {
  description = "Linux username"
  type        = string
  sensitive   = true
  default     = "yockgenm"
}

variable "pwd" {
  description = "Linux password"
  type        = string
  sensitive   = true
}

variable "nodes" {         
  default = {
              "node1"={ip="192.168.1.107"}
              "node2"={ip="192.168.1.111"}            
            }        

}

variable "gpu_sriov_config" {         
  default = [
              {id="1",exec=250,timeout=50000},
              {id="2",exec=250,timeout=30001},                          
              {id="3",exec=250,timeout=20},
              {id="4",exec=10,timeout=20},
              {id="5",exec=250,timeout=20},
              {id="6",exec=250,timeout=20},
              {id="7",exec=250,timeout=20}
            ]        

}
