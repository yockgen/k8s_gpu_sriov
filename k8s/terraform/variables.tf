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

variable "gpu_sriov_settings" {         
  default = {
              "card1"={exec="25",timeout="50000"}
              "card2"={exec="25",timeout="50000"}
                          
            }        

}
