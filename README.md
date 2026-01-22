# Beep Central - Full Stack Docker Compose

This repository contains the Docker Compose configuration to start the entire Beep stack.

## Clone the Repository

To clone this repository with all its submodules, use:

```bash
git clone --recurse-submodules git@github.com:beep-industries/central.git
```

If you've already cloned the repository without submodules, you can initialize/update them with:

```bash
git submodule update --init --recursive
```

## Quick Start

### 1. Starting the Full Stack

To start **all services**, simply run:

```bash
docker compose --profile all up -d
```

All services come with sensible defaults and will work out of the box.

### 2. Environment Configuration (Optional)

If you need to override any environment variables:

```bash
cp .env.example .env
```

Then edit `.env` with your custom values. The docker-compose will automatically pick up your changes.

### 3. Developing a Specific Service

The profile system allows you to start all infrastructure **EXCEPT** the service you're working on.

#### Working on the User Service

```bash
# Starts everything EXCEPT user-api (you run it locally)
docker compose --profile user up -d
```

#### Working on the Communities Service

```bash
# Starts everything EXCEPT communities-api (you run it locally)
docker compose --profile communities up -d
```

#### Working on the Message Service

```bash
# Starts everything EXCEPT message-api (you run it locally)
docker compose --profile message up -d
```

#### Working on the Real-time Service

```bash
# Starts everything EXCEPT realtime-api (you run it locally)
docker compose --profile realtime up -d
```

#### Working on the Authz Service

```bash
# Starts everything EXCEPT authz-listeners (you run it locally)
docker compose --profile authz up -d
```

#### Working on the Client (Frontend)

```bash
# Starts everything EXCEPT client (you run it locally)
docker compose --profile client up -d
```

## Available Services

### Infrastructure (always started)

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

## Useful Commands

### View logs for a service

```bash
docker compose logs -f <service-name>
```

### Stop all services

```bash
docker compose down
```

### Stop and remove volumes

```bash
docker compose down -v
```

### Rebuild a service

```bash
docker compose build <service-name>
```

### Check service status

```bash
docker compose ps
```

## Service Access

- **Keycloak Admin**: http://localhost:8080/admin (admin/admin by default)
- **RabbitMQ Management**: http://localhost:15672 (guest/guest)
- **User API**: http://localhost:3000
- **Communities API**: http://localhost:8081
- **Message API**: http://localhost:8083
- **Real-time API**: http://localhost:4000
- **Client**: http://localhost

## Structure

```
.
├── authz/              # Authorization service
├── client/             # Frontend
├── communities/        # Communities service
├── message/            # Messaging service
├── real-time/          # Real-time service
├── user/               # User service
├── docker-compose.yaml # Main configuration
└── setup-env.sh        # Setup script
```

## Environment Variables

Each service has its own `.env` file. Check the `.env.example` files of each service to see the available variables.

## Important Notes

1. Make sure you have Docker and Docker Compose installed
2. Infrastructure services start automatically
3. Application services require a profile to start
4. Change the default passwords before deploying to production
