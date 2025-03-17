#! /usr/bash

# Mise à jour du système
apt update && apt upgrade -y

# Sécurisation de la connexion SSH
## TODO : téléchargement du fichier
## TODO : Modification de la configuration

# Installation de Fail2Ban
apt install fail2ban

# Installation ufw
apt install ufw
# Ajout de règles
ufw allow OpenSSH
ufw allow 80
ufw allow 443
ufw enable

# Installation de Docker
# Add Docker's official GPG key:
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Ajout de l'utilisateur au groupe Docker
usermod -aG docker ubuntu
