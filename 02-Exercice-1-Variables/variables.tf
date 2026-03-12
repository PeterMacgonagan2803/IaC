variable "docker_image" {
  description = "Nom de l'image Docker"
  type        = string
  default     = "nginx:latest"
}

variable "container_name" {
  description = "Nom du conteneur"
  type        = string
  default     = "nginx-terraform"
}

variable "port_external" {
  description = "Port externe exposé sur l'hôte"
  type        = number
  default     = 8080
}

variable "port_internal" {
  description = "Port interne du conteneur"
  type        = number
  default     = 80
}
