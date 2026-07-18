terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.0"

    }
  }
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

# 1. Définition du Réseau Privé (VPC)
resource "scaleway_vpc_private_network" "navineo_vpc" {
  name = "navineo-internal-network"
}

# 2. 18 VMs Docker 
resource "scaleway_instance_server" "docker_nodes" {
  count = var.node_count

  name  = "navineo-node-${format("%02d", count.index + 1)}"
  type  = "DEV1-S" # Format économique pour dev/test (2 CPU, 4GB RAM, 20GB SSD)
  image = "ubuntu_jammy"
}
  private_network {
    pn_id = scaleway_vpc_private_network.navineo_vpc.id
  }

  # Cloud-init: Installation de Docker
  user_data = {
    cloud-init = <<-EOT
                 #!/bin/bash
                 apt-get update -y
                 apt-get install -y docker.io docker-compose
                 systemctl enable --now docker
                 EOT
  }

# 3. La Base de Données PostgreSQL
resource "scaleway_rdb_instance" "navineo_db" {
  name           = "navineo-postgres-cluster"
  node_type      = "DB_DEV_S"
  engine         = "PostgreSQL-15"
  is_ha_cluster  = false # True pour la prod, False pour dev
  disable_backup = false # True pour la prod, False pour dev
  user_name      = "admin_navineo"
  password       = "var.db_password"
}
