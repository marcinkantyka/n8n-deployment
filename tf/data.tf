data "hcloud_ssh_key" "key" {
  name = var.ssh_key_name
}