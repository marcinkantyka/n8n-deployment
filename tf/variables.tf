variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.hcloud_token) > 0
    error_message = "The hcloud_token variable must not be empty."
  }
}

variable "firewall_rules" {
  description = "values for the firewall rules to be applied"
  type = list(object({
    protocol   = string
    port       = string
    source_ips = list(string)
  }))
  
}