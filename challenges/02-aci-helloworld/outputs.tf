output "public_ip_address" {
  description = "The actual fqdn allocated for the resource."
  value       = "${azurerm_container_group.main.*.fqdn}"
}
