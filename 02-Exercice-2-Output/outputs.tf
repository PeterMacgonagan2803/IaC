output "nginx_container_id" {
  description = "Identifiant du conteneur nginx"
  value       = docker_container.nginx.id
}
