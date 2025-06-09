firewall_rules = [
  {
    protocol   = "tcp"
    port       = "22"
    source_ips = ["217.119.67.226/32"]
  },
  {
    protocol   = "tcp"
    port       = "443"
    source_ips = ["217.119.67.226/32"]
  },
  {
    protocol   = "tcp"
    port       = "5678"
    source_ips = ["217.119.67.226/32"]
  }
]

server_name = "goblin"

ssh_key_name = "wsl-ssh-pub"
domain_name  = "n8n.boreddevops.xyz"

#admin_username = "admin"
#admin_password = "ChangeMePassword123!"
