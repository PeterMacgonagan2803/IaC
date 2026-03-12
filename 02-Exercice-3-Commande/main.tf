terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "tcp://localhost:2375"
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
}

resource "null_resource" "test_nginx" {
  depends_on = [docker_container.nginx]

  provisioner "local-exec" {
    command = "powershell -NoProfile -Command \"Start-Sleep -Seconds 3; $r = Invoke-WebRequest -Uri 'http://localhost:${var.port_external}' -UseBasicParsing; if ($r.Content -notmatch 'Welcome') { exit 1 }\""
  }
}
