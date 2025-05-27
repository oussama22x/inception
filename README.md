# 🐳 Inception

*Multi-container Docker environment orchestration*

## Overview

A complete infrastructure setup using Docker Compose to deploy a web application stack with NGINX, WordPress, and MariaDB in separate containers.

## 🏗️ Architecture

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    NGINX    │───▶│  WordPress  │───▶│   MariaDB   │
│  (Reverse   │    │    (PHP)    │    │ (Database)  │
│   Proxy)    │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
```

## 🚀 Quick Start



## 📦 Services

**NGINX** - Web server and reverse proxy  
**WordPress** - Content management system  
**MariaDB** - Database server  

## 🛠️ Key Features

- **Custom Dockerfiles** for each service
- **Docker Compose** orchestration
- **Volume persistence** for data
- **Network isolation** between containers
- **SSL/TLS encryption** via NGINX
- **Environment variables** for configuration


## 🎯 Project Goals

This project demonstrates containerization principles, service orchestration, and infrastructure as code practices. Each service runs in its own isolated environment while maintaining secure communication channels.

---

*Clean containers, clean architecture* ✨
