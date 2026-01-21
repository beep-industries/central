# Beep Central - Full Stack Docker Compose

Ce repository contient la configuration Docker Compose pour démarrer l'ensemble de la stack Beep.

## 🚀 Démarrage rapide

### 1. Configuration des environnements

Exécutez le script pour copier les fichiers `.env.example` vers `.env` dans chaque service :

```bash
./setup-env.sh
```

Ensuite, configurez les valeurs dans chaque fichier `.env` créé selon vos besoins.

### 2. Démarrage de la stack complète

Pour démarrer **tous les services** :

```bash
docker compose --profile all up -d
```

### 3. Développement sur un service spécifique

Le système de profils permet de démarrer toute l'infrastructure **SAUF** le service sur lequel vous travaillez.

#### Travailler sur le service User

```bash
# Démarre tout SAUF user-api (vous le lancez en local)
docker compose --profile user up -d
```

#### Travailler sur le service Communities

```bash
# Démarre tout SAUF communities-api (vous le lancez en local)
docker compose --profile communities up -d
```

#### Travailler sur le service Message

```bash
# Démarre tout SAUF message-api (vous le lancez en local)
docker compose --profile message up -d
```

#### Travailler sur le service Real-time

```bash
# Démarre tout SAUF realtime-api (vous le lancez en local)
docker compose --profile realtime up -d
```

#### Travailler sur le service Authz

```bash
# Démarre tout SAUF authz-listeners (vous le lancez en local)
docker compose --profile authz up -d
```

#### Travailler sur le Client (Frontend)

```bash
# Démarre tout SAUF client (vous le lancez en local)
docker compose --profile client up -d
```

## 📋 Services disponibles

### Infrastructure (toujours démarrée)

- **user-db** (PostgreSQL) - Port 5432
- **keycloak-db** (PostgreSQL)
- **keycloak** - Port 8080
- **communities-db** (PostgreSQL) - Port 5433
- **message-db** (MongoDB) - Port 27017
- **rabbitmq** - Ports 5672 (AMQP), 15672 (Management)
- **spicedb** - Ports 50051, 8443
- **otel-collector** - Ports 4317, 4318, 8888

### Application Services

- **user-api** - Ports 3000, 3001
- **communities-api** - Ports 8081, 8082
- **message-api** - Port 8083
- **realtime-api** - Port 4000
- **authz-listeners**
- **client** - Port 80

## 🛠️ Commandes utiles

### Voir les logs d'un service

```bash
docker compose logs -f <service-name>
```

### Arrêter tous les services

```bash
docker compose down
```

### Arrêter et supprimer les volumes

```bash
docker compose down -v
```

### Reconstruire un service

```bash
docker compose build <service-name>
```

### Vérifier l'état des services

```bash
docker compose ps
```

## 🌐 Accès aux services

- **Keycloak Admin**: http://localhost:8080/admin (admin/admin par défaut)
- **RabbitMQ Management**: http://localhost:15672 (guest/guest)
- **User API**: http://localhost:3000
- **Communities API**: http://localhost:8081
- **Message API**: http://localhost:8083
- **Real-time API**: http://localhost:4000
- **Client**: http://localhost

## 📁 Structure

```
.
├── authz/              # Service d'autorisation
├── client/             # Frontend
├── communities/        # Service des communautés
├── message/            # Service de messagerie
├── real-time/          # Service temps réel
├── user/               # Service utilisateur
├── docker-compose.yaml # Configuration principale
└── setup-env.sh        # Script de configuration
```

## 🔧 Variables d'environnement

Chaque service possède son propre fichier `.env`. Consultez les fichiers `.env.example` de chaque service pour voir les variables disponibles.

## ⚠️ Notes importantes

1. Assurez-vous d'avoir Docker et Docker Compose installés
2. Les services d'infrastructure démarrent automatiquement
3. Les services d'application nécessitent un profil pour démarrer
4. Modifiez les mots de passe par défaut avant de déployer en production
