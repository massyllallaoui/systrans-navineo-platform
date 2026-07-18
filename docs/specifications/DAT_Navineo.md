# Document d'Architecture Technique (DAT) - Navineo Integration
**Statut :** Validé
**Version :** 1.0

## 1. Contexte du Projet
Ce document définit l'architecture système requise pour l'interfaçage du système Navineo avec des services externes (EasyPark, Filexis, services Siri). Conformément aux exigences du client, l'hébergement est assuré sur le cloud **Scaleway**.

## 2. Architecture Physique (Infrastructure as Code)
L'infrastructure est déployée via Terraform pour garantir l'idempotence.
*   **Réseau :** Création d'un Virtual Private Cloud (VPC) isolé.
*   **Calcul (Compute) :** Déploiement d'une flotte de 18 Machines Virtuelles (VMs).
*   **Données :** Instance PostgreSQL managée pour la persistance des données transactionnelles.

## 3. Architecture Applicative (Conteneurisation)
Chaque VM agit comme un nœud Docker indépendant. Les services d'interfaçage (EasyPark, Filexis, etc.) sont isolés dans des conteneurs, permettant des mises à jour sans interruption globale du service Navineo.

## 4. Sécurité (Zero Trust)
*   Les VMs n'exposent que les ports strictement nécessaires (ex: 443 pour les API HTTPS).
*   La base de données PostgreSQL n'est accessible que depuis le réseau privé interne (VPC).
