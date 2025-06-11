

variable "firewall_rules" {
  description = "values for the firewall rules to be applied"
  type = list(object({
    protocol   = string
    port       = string
    source_ips = list(string)
  }))
  
}

variable "server_name" {
  description = "name of the server to be created"
  type        = string
  default     = "goblin"
} 

variable "ssh_key_name" {
  description = "name of the ssh key to be used"
  type        = string
}

variable "domain_name" {
  description = "domain name to be used"
  type        = string
}

variable "admin_username" {
  description = "username for the admin user"
  type        = string
}

variable "admin_password" {
  description = "password for the admin user"
  type        = string
  sensitive   = true
}