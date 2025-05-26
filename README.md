# 🐳 Inception

<div align="center">

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

*A complete containerized web application infrastructure using Docker*

</div>

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [Services](#-services)
- [Configuration](#-configuration)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)

## 🎯 Overview

Inception is a Docker-based infrastructure project that demonstrates the deployment of a complete web application stack using containerization. The project sets up a multi-service environment with NGINX as a reverse proxy, WordPress as the web application, and MariaDB as the database backend.

### Key Features

- 🔧 **Multi-container Setup**: Orchestrated using Docker Compose
- 🌐 **Reverse Proxy**: NGINX configuration for SSL termination and load balancing
- 📝 **Content Management**: WordPress installation with custom configuration
- 🗄️ **Database**: MariaDB with persistent storage
- 🔒 **Security**: SSL/TLS encryption and secure container networking
- 📦 **Containerization**: Each service runs in its own isolated container

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│                 │    │                 │    │                 │
│     NGINX       │────│   WordPress     │────│    MariaDB      │
│  (Reverse Proxy)│    │ (Web Application)│    │   (Database)    │
│                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                        Docker Network
```

## 🔧 Prerequisites

Before running this project, make sure you have:

- **Docker** (version 20.10+)
- **Docker Compose** (version 2.0+)
- **Make** (optional, for using Makefile commands)
- **Linux/Unix environment** (tested on Ubuntu/Debian)

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/inception.git
cd inception
```

### 2. Set Up Environment Variables

Create a `.env` file in the project root:

```bash
cp .env.example .env
```

Edit the `.env` file with your configuration:

```env
# Domain Configuration
DOMAIN_NAME=your-domain.com

# Database Configuration
DB_NAME=wordpress
DB_USER=wp_user
DB_PASSWORD=your_secure_password
DB_ROOT_PASSWORD=your_root_password

# WordPress Configuration
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@example.com
WP_USER=user
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=user@example.com

# Paths
VOLUME_PATH=/home/your-user/data
```

### 3. Create Required Directories

```bash
make dirs
# or manually:
mkdir -p /home/your-user/data/wordpress
mkdir -p /home/your-user/data/mariadb
```

## 💻 Usage

### Quick Start

```bash
# Build and start all services
make up

# Start services in detached mode
make up-d

# Stop all services
make down

# Rebuild and restart
make re

# View logs
make logs

# Clean everything (containers, images, volumes)
make fclean
```

### Manual Docker Compose Commands

```bash
# Build and start
docker-compose up --build

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f
```

## 🔧 Services

### NGINX (Reverse Proxy)

- **Port**: 443 (HTTPS)
- **Function**: SSL termination, reverse proxy to WordPress
- **Config**: Custom nginx.conf with SSL configuration
- **Certificates**: Self-signed SSL certificates (replace with real ones for production)

### WordPress (Web Application)

- **Port**: 9000 (internal, PHP-FPM)
- **Function**: Content management system
- **Database**: Connected to MariaDB
- **Volumes**: Persistent storage for WordPress files

### MariaDB (Database)

- **Port**: 3306 (internal)
- **Function**: Database backend for WordPress
- **Volumes**: Persistent storage for database files
- **Configuration**: Custom my.cnf for optimization

## ⚙️ Configuration

### Directory Structure

```
inception/
├── Makefile
├── docker-compose.yml
├── .env
├── requirements/
│   ├── nginx/
│   │   ├── Dockerfile
│   │   ├── conf/
│   │   └── tools/
│   ├── wordpress/
│   │   ├── Dockerfile
│   │   ├── conf/
│   │   └── tools/
│   └── mariadb/
│       ├── Dockerfile
│       ├── conf/
│       └── tools/
└── secrets/
    ├── db_password.txt
    ├── db_root_password.txt
    └── credentials.txt
```

### Docker Compose Services

Each service is configured with:
- Custom Dockerfile for precise control
- Health checks for reliability
- Restart policies for high availability
- Named volumes for data persistence
- Custom networks for security

### SSL Configuration

The project includes SSL/TLS encryption:
- Self-signed certificates for development
- NGINX configured for HTTPS only
- Automatic HTTP to HTTPS redirect

## 🐛 Troubleshooting

### Common Issues

**Services won't start:**
```bash
# Check service status
docker-compose ps

# View detailed logs
docker-compose logs service-name

# Restart specific service
docker-compose restart service-name
```

**Permission issues:**
```bash
# Fix volume permissions
sudo chown -R $USER:$USER /path/to/volumes
```

**Database connection issues:**
```bash
# Check database connectivity
docker-compose exec wordpress wp db check

# Reset database
make fclean && make up
```

**SSL Certificate issues:**
```bash
# Regenerate certificates
docker-compose exec nginx openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt
```

### Useful Commands

```bash
# Enter container shell
docker-compose exec service-name bash

# Check container resources
docker stats

# Inspect network
docker network inspect inception_network

# View volume contents
docker volume ls
docker volume inspect volume-name
```

## 📊 Monitoring

### Health Checks

All services include health checks:
- **NGINX**: HTTP response check
- **WordPress**: PHP-FPM process check
- **MariaDB**: Database connection check

### Logs

Access logs for debugging:
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f nginx
docker-compose logs -f wordpress
docker-compose logs -f mariadb
```

## 🔒 Security Considerations

- All services run as non-root users
- Database credentials stored in Docker secrets
- NGINX configured with security headers
- Services communicate through isolated Docker networks
- File permissions properly configured

## 🚀 Production Deployment

For production use:

1. **Replace self-signed certificates** with real SSL certificates
2. **Use Docker secrets** for sensitive data
3. **Configure backup strategies** for persistent volumes
4. **Set up monitoring** and alerting
5. **Implement proper logging** solutions
6. **Configure firewall rules** appropriately

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📜 License

This project is part of the 42 School curriculum and follows their guidelines.

---

<div align="center">

**Built with ❤️ as part of 1337 School (42 Network) curriculum**

</div>
