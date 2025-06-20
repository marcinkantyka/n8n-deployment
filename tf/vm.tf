resource "hcloud_server" "server_test" {
  name        = var.server_name
  ssh_keys    = [data.hcloud_ssh_key.key.id]
  image       = "ubuntu-24.04"
  server_type = "cx22"
  datacenter = "fsn1-dc14"
  


    labels = {
        "created_by"  = "terraform"
    }
 
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

    firewall_ids = [hcloud_firewall.custom.id]

    user_data = templatefile("${path.module}/userdata.yml", {
        domain_name    = var.domain_name
        admin_username = var.admin_username
        admin_password = var.admin_password
        }
)
}