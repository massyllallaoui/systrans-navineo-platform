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

# 1. Le Réseau Privé (VPC)
resource "scaleway_vpc_private_network" "navineo_vpc" {
  name = "navineo-internal-network"
}

# 2. La flotte de 18 VMs Docker (Allégée)
resource "scaleway_instance_server" "docker_nodes" {
  count = var.node_count

  name  = "navineo-node-${format("%02d", count.index + 1)}"
  type  = "DEV1-S"
  image = "ubuntu_jammy"

  # Utilisation de l'argument natif cloud_init (Texte brut, pas de dictionnaire)
  cloud_init = <<-EOT
               #!/bin/bash
               apt-get update -y
               apt-get install -y docker.io docker-compose
               systemctl enable --now docker
               EOT
}

# 3. Attachement Réseau Sécurisé (Best Practice Scaleway)
resource "scaleway_instance_private_nic" "docker_nodes_nic" {
  count              = var.node_count
  server_id          = scaleway_instance_server.docker_nodes[count.index].id
  private_network_id = scaleway_vpc_private_network.navineo_vpc.id
}

# 4. La Base de Données PostgreSQL
resource "scaleway_rdb_instance" "navineo_db" {
  name           = "navineo-postgres-cluster"
  node_type      = "DB-DEV-S"
  engine         = "PostgreSQL-15"
  is_ha_cluster  = false
  disable_backup = false
  user_name      = "admin_navineo"
  password       = var.db_password
}
