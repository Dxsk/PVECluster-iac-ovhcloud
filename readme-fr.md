# 🚀 Proxmox VE Lab Environnement sur le Cloud public OVH

Ce projet vous permet de déployer et configurer automatiquement un environnement Proxmox VE sur le Cloud public OVH en utilisant les principes IaC (Infrastructure as Code). ⚡️

## 📁 Structure du projet

Le projet est organisé en deux répertoires principaux:

### 🏗️ /deployer

Contient le code OpenTofu (Terraform) pour fournir l’infrastructure :

- 🖥️ Crée 12 instances Debian sur le cloud public OVH
- 🌐 Met en place des réseaux et des groupes de sécurité
- 💾 Gère les volumes de stockage de blocs supplémentaires
- 📤 Affiche des informations d’instance pour Ansible

Fichiers clés :
- ‘main.tf’- 📋 Définition de l’infrastructure principale
- ‘variables.tf’- ⚙️ Déclarations de variables
- ‘outputs.tf’- 📊 Définitions des extrants
- «providers.tf»- 🔌 Configurations du fournisseur

### 🛠️ /provisioner 

Contient les playbooks d’Ansible pour configurer les instances :

- 📦 Installe et configure Proxmox VE
- 🔧 Configuration du réseau et du stockage
- 🔒 Configure les paramètres de sécurité
- ✅ Gère les tâches post-installation

Fichiers clés :
- ‘site.yml’’- 📘 Guide principal
- ‘inventory.yml’- 📝 Inventaire dynamique (généré)
- ‘group_vars/`- ⚙️ Variables de groupe
- «Rôles/»- 🎭 Rôles possibles pour les différentes composantes

## 🔄 Flux d’utilisation

1. Utiliser le déploiement pour créer l’infrastructure :
   ``bash
   CD Déployateur
   tofu init
   plan de tofu
   tofu appliquer
   ``

2. Utiliser le fournisseur pour configurer les instances :
   ``bash
   cd .. /provisioner
   ansible-playbook -i inventory.yml site.yml
   ``

## 📚 Documentation

- 📖 Voir le document « deployer/README.md » pour obtenir des instructions détaillées sur le déploiement de l’infrastructure
- 📗 Voir le document « provisioner/README.md » pour les détails de la gestion de la configuration
- 📘 Vérifier la documentation des rôles individuels dans le fichier `provisioner/roles/*/README.md

