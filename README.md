# SysAdmin - Ubuntu

Ce projet est là pour lister des bonnes pratiques de gestion d'un serveur et administrer ce système pour héberger des applications web, avec le gestionnaire de conteneur Docker.

## Objectif

Nous allons travailler avec Docker, ce qui permet de répartir le travail et d’éviter les surprises au déploiement.  
Nous allons préparer le serveur et ensuite installer et configurer tout ce qu’il faut pour déployer notre première application
- Installer l'OS
- Sécuriser
- Préparer le déploiement
- Préparer le suivi
- Mises à jour régulières

## Installer l'OS

Sur OVH, l'installation de l'OS se lance depuis l'interface d'accueil d'OVH.  
Il suffit de choisir l'OS et de définir sa clé SSH et de lancer le formatage.  
À l'heure de l'écriture de ce texte, on installe Ubuntu 24.  

Une fois l'OS installé, il faut bien penser à mettre à jour le système : 
```bash
apt update && apt upgrade -y
```

## Sécuriser le serveur

Sécuriser le serveur passe par plusieurs étapes : 
- Mettre à jour le système : voir section au dessus
- Connexion uniquement par clé SSH
- Installer Fail2ban
- Configurer et préparer le parefeu UFW
- Utiliser un utilisateur 

## Préparer pour les déploiements

Installer Docker et Traefik pour gérer les requêtes et les traiter par le service voulu.

- Installer Docker
  - [Documenation Docker](https://docs.docker.com/engine/install/ubuntu/)
- Installer Traefik et le configurer
- Authentifier docker aux registry

## Préparer pour le monitoring



## Mettre à jour régulières

- apt update && apt upgrade -y && shutdown -r

## Information pratique

- Transférer des fichiers avec `rsync`
- Utiliser `crontab`