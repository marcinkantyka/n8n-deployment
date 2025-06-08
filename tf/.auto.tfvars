firewall_rules = [
  {
    protocol   = "tcp"
    port       = "22"
    source_ips = ["217.119.67.226/32"]
  },
  {
    protocol   = "tcp"
    port       = "any"
    source_ips = ["0.0.0.0/0"]
  }
]