variable "machines" {
  description = "Liste des machines virtuelles (nom, vCPU, disque Go, région)"
  type = list(object({
    name      = string
    vcpu      = number
    disk_size = number
    region    = string
  }))
  default     = []

  validation {
    condition = alltrue([
      for m in var.machines : m.vcpu >= 2 && m.vcpu <= 64
    ])
    error_message = "Le nombre de vCPU doit être entre 2 et 64 pour chaque machine."
  }

  validation {
    condition = alltrue([
      for m in var.machines : m.disk_size >= 20
    ])
    error_message = "La taille du disque doit être d'au moins 20 Go pour chaque machine."
  }

  validation {
    condition = alltrue([
      for m in var.machines : contains(["eu-west-1", "us-east-1", "ap-southeast-1"], m.region)
    ])
    error_message = "La région doit être l'une des suivantes : eu-west-1, us-east-1, ap-southeast-1."
  }
}
