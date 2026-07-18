variable "db_password" {
  description = "Mot de passe administrateur pour PostgreSQL"
  type        = string
  sensitive   = true
}

variable "node_count" {
  description = "Nombre de VMs Docker à déployer"
  type        = number
  default     = 18
}
