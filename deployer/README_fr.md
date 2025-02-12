# Lab Proxmox VE sur OVH Public Cloud

Ce projet OpenTofu permet de déployer automatiquement un environnement Proxmox VE (PVE) sur OVH Public Cloud en utilisant une instance Debian 12 comme base.

## Description

Ce projet automatise la création d'un serveur Proxmox VE pour un environnement de lab/test. Il :
- Déploie une instance Debian 12 sur OVH Public Cloud
- Configure les prérequis système
- Installe et configure Proxmox VE
- Configure le réseau et la sécurité de base

### Spécifications de l'instance
- Type : d2-2 (2 vCPUs, 4GB RAM)
- OS : Debian 12 (Bookworm)
- Région : GRA11 (configurable)
- Réseau : Accès public

## Prérequis

- [OpenTofu](https://opentofu.org/) installé localement
- Un compte OVH Public Cloud
- Les credentials API OVH et OpenStack
- Un accès SSH configuré

## Configuration

1. Créez vos credentials API OVH sur [https://api.ovh.com/createToken/](https://api.ovh.com/createToken/)
Droits API nécessaires :
```
GET    /cloud/*
POST   /cloud/*
PUT    /cloud/*
DELETE /cloud/*
```

2. Récupérez vos credentials OpenStack :
- Allez dans Public Cloud > Users & Roles > Download OpenStack RC File

3. Préparez votre configuration :
```bash
# Copiez le fichier d'exemple
cp terraform.tfvars.example terraform.tfvars

# Éditez le fichier avec vos credentials
vim terraform.tfvars
```

## Déploiement

```bash
# Initialisation
tofu init

# Vérification du plan
tofu plan

# Déploiement
tofu apply

# Pour détruire l'infrastructure
tofu destroy
```

## Post-installation

Une fois l'instance déployée :

1. Connectez-vous via SSH :
```bash
ssh debian@<instance_ip>
```

2. L'interface web Proxmox sera accessible sur :
```
https://<instance_ip>:8006
```

## Variables

| Nom | Description | Type | Défaut | Requis |
|------|-------------|------|---------|:--------:|
| environment | Environnement (dev, prod, etc.) | string | - | oui |
| project_name | Nom du projet | string | - | oui |
| region | Région OVH | string | "GRA11" | non |
| openstack_tenant_id | ID du projet OpenStack | string | - | oui |
| ... | ... | ... | ... | ... |

## Outputs

| Nom | Description |
|------|-------------|
| instance_ip | IP publique de l'instance Proxmox |

## Sécurité

⚠️ Points importants :
- Changez les mots de passe par défaut
- Configurez un pare-feu approprié
- Utilisez des VPN pour l'accès distant en production
- Ce projet est conçu pour un lab, des configurations supplémentaires sont nécessaires pour la production

## Limitations connues

- Configuration basique de Proxmox (parfait pour un lab)
- Une seule instance (pas de cluster)
- Réseau public uniquement (considérez un VPN pour la production)

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Ouvrir une issue pour les bugs
- Proposer des améliorations
- Soumettre des pull requests

## Licence

MIT

## Support

Pour toute question ou problème :
1. Consultez les issues existantes
2. Ouvrez une nouvelle issue si nécessaire 