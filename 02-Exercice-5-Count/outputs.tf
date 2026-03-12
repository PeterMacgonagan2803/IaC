output "nginx_container_id" {
  description = "Identifiant du conteneur nginx"
  value       = docker_container.nginx.id
}

output "client_container_ids" {
  description = "Identifiants des conteneurs client"
  value       = docker_container.client[*].id
}

output "network_name" {
  description = "Nom du réseau Docker"
  value       = docker_network.app_network.name
}
