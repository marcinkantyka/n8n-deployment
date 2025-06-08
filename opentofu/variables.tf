
variable "firewall_rules" {
  type = list(object({
    protocol   = string
    port       = string
    source_ips = list(string)
  }))
  
}