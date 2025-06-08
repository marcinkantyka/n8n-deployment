

variable "firewall_rules" {
  description = "values for the firewall rules to be applied"
  type = list(object({
    protocol   = string
    port       = string
    source_ips = list(string)
  }))
  
}