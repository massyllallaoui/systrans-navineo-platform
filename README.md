# 🚉 Plateforme d'Interfaçage Navineo - Infrastructure & Déploiement

## 🎯 Vision du Projet
Ce dépôt contient l'intégralité du code d'infrastructure (IaC), de l'architecture applicative et de la documentation opérationnelle imaginé pour le système d'interfaçage **Navineo**. 

L'objectif est d'assurer une communication sécurisée et hautement disponible entre le cœur Navineo et des prestataires externes (**EasyPark**, **Filexis**, **Services Siri VM/ET/GM**).

## ⚙️ Architecture Cloud (Scaleway)
Conformément aux exigences d'hébergement, la plateforme est propulsée sur **Scaleway**. L'infrastructure est modulaire et automatisée via **Terraform** :
- **Compute :** Déploiement automatisé d'un parc de **18 Machines Virtuelles** isolées.
- **Conteneurisation :** Provisionnement de **Docker** via *Cloud-init* sur chaque nœud pour exécuter les connecteurs externes de manière indépendante.
- **Persistance :** Instance **PostgreSQL** managée (RDB) sécurisée.
- **Réseau :** Encapsulation des flux dans un Réseau Privé (VPC) Zero-Trust.

## 📂 Arborescence du Projet
- `/infra/scaleway/` : Code Terraform (Réseau, VMs, Base de données).
- `/apps/docker/` : Architecture des conteneurs (Dockerfiles et docker-compose) pour les connecteurs.
- `/docs/specifications/` : Document d'Architecture Technique (DAT).
- `/docs/manuels/` : Manuels d'exploitation et procédures de maintenance.
- `.github/workflows/` : Pipeline CI/CD pour l'audit continu de l'infrastructure.

## 🚀 Intégration et Déploiement Continu (CI/CD)
Ce dépôt applique les principes du **DevOps**. À chaque `push`, un workflow GitHub Actions est déclenché pour :
1. Initialiser l'environnement Terraform.
2. Auditer la conformité du code (`terraform fmt -check`).
3. Valider mathématiquement les dépendances du graphe d'infrastructure (`terraform validate`).
