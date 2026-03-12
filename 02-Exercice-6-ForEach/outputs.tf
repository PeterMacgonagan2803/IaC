output "nginx_container_id" {
  description = "Identifiant du conteneur nginx"
  value       = docker_container.nginx.id
}

output "server_container_ids" {
  description = "Identifiants des conteneurs server (nom -> id)"
  value       = { for k, c in docker_container.client : k => c.id }
}

output "network_name" {
  description = "Nom du réseau Docker"
  value       = docker_network.app_network.name
}
