terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "local" {}

resource "local_file" "test_file" {
  content  = "Hello depuis Terraform - modifié !"
  filename = "${path.module}/hello.txt"
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Commande exécutée !'"
  }
}
