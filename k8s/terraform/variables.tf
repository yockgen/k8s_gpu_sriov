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
  default = ["192.168.1.107","192.168.1.111"]        
}
