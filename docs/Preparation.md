# Préparer pour les déploiements

Installer Docker et Traefik pour gérer les requêtes et les traiter par le service voulu.

- Installer Docker
- Installer Traefik et le configurer
- Authentifier docker aux registry

## Docker

Docker est décrit sur [wikipédia](https://fr.wikipedia.org/wiki/Docker_(logiciel)) et sa documentation est sur [docs.docker.com](https://docs.docker.com/), on la retrouve également sur la [documentation ubuntu](https://doc.ubuntu-fr.org/docker)

Docker est un moteur de gestion de service par conteneur. À partir d'une configuration, on crée une image docker, contenant tout ce que le service a besoin. On peut démarrer un conteneur à partir d'une image. Avec docker on peut même lancer plusieurs services avec un fichier compose.yaml et on peut même gérer les conteneurs sous clustering de serveur avec Docker Swarm.

Docker est un allié de taille pour gérer facilement les services sur un serveur.

Installation : 
Il existe plusieurs méthodes pour installer docker dans sa [doc](https://docs.docker.com/engine/install/ubuntu/#installation-methods)

Plus d'information disponible dans la [formation Docker](https://github.com/botlane-feeder/tryingtech-docker)

## Traefik

Traefik est décrit sur sa documentation est sur [doc.traefik.io](https://doc.traefik.io/traefik/).

Traefik est un reverse proxy et permet de gérer une redirection d'une requête sur votre serveur vers le service Docker souhaité.
Son grand avantage est qu'il gère "à chaud" ses redirection.
Il est capable de gérer les certificats SSL des services.


Installation :
La facilité de Traefik est que c'est un service déjà conterisé, il suffit de démarrer le conteneur et de le configurer : [doc](https://doc.traefik.io/traefik/getting-started/quick-start/)





## Authentifier docker aux registry

Pour pouvoir télécharger les images docker et les démarer sur le serveur, il faut que docker s'authentifie auprès des différents registry.  

```bash
docker login -u ${USERNAME} ${REGISTRY_NAME}
```
Puis tapper le mot de passe.

Pour cela il faut au préalable créer un token de lecture sur la plateforme de registry, récupérer le mot de passe généré grace à votre nom d'utilisateur et le renseigner lors du `docker login`.


Les regitries connus : 
- [github](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-docker-registry) : ghcr.io
- [gitlab](https://docs.gitlab.com/user/packages/container_registry/) : registry.gilab.com