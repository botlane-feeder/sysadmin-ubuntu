# Securiser le serveur

Sécuriser le serveur passe par plusieurs étapes : 
- Mettre à jour le système : voir section au dessus
- Connexion uniquement par clé SSH
- Installer Fail2ban
- Configurer et préparer le parefeu UFW
- Utiliser un utilisateur 

## Connexion uniquement par SSH

SSH (Secure Shell) est décrit sur [wikipédia](https://fr.wikipedia.org/wiki/OpenSSH) et sa documentation est sur [openssh.com](https://www.openssh.com/), on la retrouve également sur la [documentation ubuntu](https://doc.ubuntu-fr.org/ssh)

La connexion SSH se fait par deux services : 
- openssh-server : à installer sur le serveur 
- openssh-client : à installer sur le pc utilisateur

Le principe repose sur une clé privée, à garder absolument secrete (privée !) et une clé publique à déposer sur le serveur.
On génère la clé avec ssh-keygen : *ssh-keygen — OpenSSH authentication key utility* :
```bash
ssh-keygen -f ~/.ssh/${NOM_DE_LA_CLE}$ -t ed25519
```
En déterminant un passphrase, un mot de passe pour ouvrir la connexion entre le client et le serveur qui a la clé publique dans son fichier `/home/${NAME_USER}/.ssh/authorized_keys/`.

Puis la configuration server sur fait dans le fichier `/etc/ssh/sshd_config`.
- à ne pas confondre avec `/etc/ssh/ssh_config` : sans le `d`, ça ne concerne pas le `daemon`

Il est importe de désactiver :
- `PermitRootLogin	no`	Désactive la connexion SSH en root pour limiter les risques d’attaques ciblant ce compte.
- `PasswordAuthentication	no`	Interdit l’authentification par mot de passe au profit des clés SSH.

Vérifier le fichier grace à la commande `sudo sshd -t`
Puis redémarrer le service ssh : `systemctl restart sshd`

Un guide de bonne pratique est disponible sur le blog de [Stéphane Robert](https://blog.stephane-robert.info/docs/securiser/durcissement/ssh/)

**Important :** Le changement du port 22 n'est pas forcément recommandé, il fragile votre organisation et ne bloque pas mieux les attaques, seulement les scans automatques.

Pour mieux sécuriser on peut utiliser [port-knocking](https://doc.ubuntu-fr.org/port-knocking)
- afin de n'ouvrir le port 22 qu'après une suite de ping sur d'autres ports
Et surtout il faut utiliser un système de prison comme [fail2ban](https://doc.ubuntu-fr.org/fail2ban)
- afin de limiter les tentatives par adresses IP

## Fail2Ban

Fail2Ban est décrit sur [wikipédia](https://fr.wikipedia.org/wiki/Fail2ban) et sa documentation est sur [github](https://github.com/fail2ban/fail2ban), on la retrouve également sur la [documentation ubuntu](https://doc.ubuntu-fr.org/fail2ban)

Le principe de Fail2Ban est de bannier une adresse IP qui aurait fait trop de tentatives ratées de connexion.  
L'adresse banie se retrouve dans une prison pour un temps configuré, et rend impossible toute nouvelle tentative de connexion.

Installation :
```bash
apt install fail2ban
```

Vérification du service : 
```bash
systemctl status fail2ban
```


On peut aussi mettre son adresse IP dans un whitelist, pour être sûr de ne jamais se retrouver en prison.
Dans le fichier de configuration de la prison `/etc/fail2ban/jail.conf`, on ajoute la commande `ignoreip=` suivi de votre adresse IP


## UFW

UFW (Uncomplicated FireWall) est décrit sur [wikipédia](https://fr.wikipedia.org/wiki/Uncomplicated_Firewall) et sa documentation est sur [launchpad](https://launchpad.net/ufw), on la retrouve également sur la [documentation ubuntu](https://doc.ubuntu-fr.org/ufw)


Installation :  
```bash
apt install ufw
```  
*UFW est préinstallé sur ubuntu*

Vérification du service :  
```bash
sudo ufw status
```
*Si UFW n'est pas activé, il n'affichera aucune configuration*


Ajout des règles :
```bash
ufw allow OpenSSH
ufw allow 80
ufw allow 443
```

Lancement de UFW :  
```bash
ufw enable
```


## Créer un utilisateur

- ..

## Aide : 

On peut mettre l'adresse IP de votre serveur dans la liste des `Hosts` : `/etc/hosts` -> `0.0.0.0 monServeur`
On peut créer un alias pour faciliter la connexion : `~/.bashrc` -> `ssh ubuntu@51.38.42.74`