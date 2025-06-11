resource "hcloud_firewall" "custom" {
  name = "custom-firewall"

  dynamic "rule" {
    for_each = var.firewall_rules
    content {
      direction  = "in"
      protocol   = rule.value.protocol
      port       = rule.value.port
      source_ips = rule.value.source_ips
    }
  }
}