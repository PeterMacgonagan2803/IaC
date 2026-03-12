terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.5.0"
    }
  }
}

provider "docker" {
  host = "tcp://localhost:2375"
}

resource "docker_network" "app_network" {
  name = "app_network"
}

resource "docker_image" "nginx" {
  name         = var.docker_image
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id

  ports {
    internal = var.port_internal
    external = var.port_external
  }

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["nginx"]
  }
}

resource "docker_container" "client" {
  name       = "client"
  image      = "appropriate/curl:latest"
  entrypoint = ["/bin/sh", "-c"]
  command    = ["sleep 5; curl -s http://nginx:80; exec tail -f /dev/null"]

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.nginx]
}
