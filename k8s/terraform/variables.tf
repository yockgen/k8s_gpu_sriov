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

