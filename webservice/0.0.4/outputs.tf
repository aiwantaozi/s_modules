output "service_ip" {
  description = "Service IP"
  value       = data.kubernetes_service.service.spec.0.cluster_ip
}

output "ports" {
  description = "Service Ports"
  value       = var.ports
}

output "images_from_var" {
  description = "Service Ports"
  value       = var.image
}
