Here's a comprehensive README for your project starter setup:


# Project Starter Setup

A production-ready Docker development environment for full-stack applications with Django backend and React/Vite frontend. This starter template provides a complete local development setup with all necessary services containerized.

## 🚀 Tech Stack

### Frontend
- **React** with **Vite** (v8+)
- Hot Module Replacement (HMR) enabled
- Cross-Origin policies configured

### Backend
- **Django** (Python web framework)
- **Celery** for async task processing
- **Flower** for Celery monitoring
- **PostgreSQL 16** for database
- **Redis 7** for caching and message broker

### Infrastructure
- **Nginx** as reverse proxy (dev and prod configs)
- **Docker** with Docker Compose for containerization
- **Makefile** for simplified command execution

## 📋 Prerequisites

- Docker and Docker Compose installed
- Make (optional, but recommended)
- Git

## 🏗️ Project Structure

```
├── backend/
│   ├── docker/
│   │   └── local/
│   │       ├── django/
│   │       │   └── Dockerfile
│   │       ├── nginx-dev/
│   │       │   ├── Dockerfile
│   │       │   └── dev.conf
│   │       └── nginx/
│   │           └── Dockerfile
│   └── .env
├── client/
│   ├── docker/
│   │   └── local/
│   │       └── Dockerfile
│   ├── vite.config.js
│   └── package.json
├── docker-compose.yml
├── Makefile
└── README.md
```

## ⚡ Quick Start

### 1. Clone and Setup

```bash
# Clone the repository
git clone <your-repo-url>
cd <project-directory>

# Create backend .env file
cp backend/.env.example backend/.env
# Edit the .env file with your configurations
```

### 2. Start Development Environment

```bash
# Start all development services
make build-dev

# Or without Make
docker compose up --build -d
```

### 3. Access the Application

- **Frontend**: http://localhost:5173 (Vite dev server with HMR)
- **Backend API**: http://localhost:8080/api/
- **Admin Panel**: http://localhost:8080/admin
- **Flower Dashboard**: http://localhost:5558 (Credentials: admin/admin1234)
- **Database**: localhost:5434

## 📜 Available Make Commands

### Development Environment
```bash
make build-dev      # Build and start all dev services
make build-prod     # Build and start production services
make up            # Start all services (without rebuilding)
make down          # Stop all services
make down-v        # Stop services and remove volumes
make show-logs     # View logs from all services
```

### Database Operations
```bash
make migrate       # Run database migrations
make makemigrations # Create new migrations
make superuser     # Create Django superuser
make cephusestate-db  # Access database shell
```

### Static Files
```bash
make collectstatic  # Collect static files
```

### Testing
```bash
make test          # Run tests with coverage
make test-html     # Generate HTML coverage report
```

### Code Quality
```bash
make flake8        # Lint check
make black-check   # Check formatting
make black-diff    # Show formatting changes needed
make black         # Apply formatting
make isort-check   # Check import sorting
make isort-diff    # Show import sorting changes
make isort         # Apply import sorting
```

### Volume Management
```bash
make volume        # Inspect PostgreSQL volume
```

## 🐳 Docker Services

| Service | Description | Port (Dev) | Port (Prod) |
|---------|-------------|------------|-------------|
| client-dev | Vite development server | 5173 | - |
| api | Django backend | - | - |
| nginx-dev | Development reverse proxy | 8080 | - |
| nginx | Production reverse proxy | - | 80, 443 |
| monseen-db | PostgreSQL database | 5434 | 5434 |
| redis | Redis server | - | - |
| celery_worker | Async task processor | - | - |
| celery_beat | Scheduled task runner | - | - |
| flower | Celery monitoring dashboard | 5558 | 5558 |

## 🔧 Configuration

### Environment Variables

Create `backend/.env` with the following variables:

```env
# Database
POSTGRES_DB=your_db_name
POSTGRES_USER=your_user
POSTGRES_PASSWORD=your_password
POSTGRES_HOST=monseen-db
POSTGRES_PORT=5432

# Django
SECRET_KEY=your-secret-key
DEBUG=1
ALLOWED_HOSTS=localhost,127.0.0.1

# Redis
REDIS_URL=redis://redis:6379/0

# Celery
CELERY_BROKER_URL=redis://redis:6379/0
```

### Vite Configuration

The Vite dev server is configured to:
- Listen on all network interfaces (`0.0.0.0`)
- Enable HMR for fast development
- Cross-Origin policies for security
- Vendor chunk optimization in builds

### Nginx Configuration

The development Nginx configuration includes:
- API proxying to Django backend
- WebSocket support
- Static file serving with caching
- CORS headers for Vite dev server (localhost:5173)
- Gzip compression
- Media file serving with caching

## 🔄 Development Workflow

1. **Start Development**: `make build-dev`
2. **Frontend Changes**: Edit files in `./client/` - HMR will auto-reload
3. **Backend Changes**: Edit files in `./backend/` - server will auto-reload
4. **Database Changes**: 
   ```bash
   make makemigrations
   make migrate
   ```
5. **View Logs**: `make show-logs`
6. **Stop Environment**: `make down`

## 🚢 Production Deployment

```bash
# Build production environment
make build-prod

# Run migrations
make migrate

# Collect static files
make collectstatic
```

## 🐛 Troubleshooting

### Vite Dev Server Not Accessible
- Ensure `host: '0.0.0.0'` is set in `vite.config.js`
- Check that port 5173 is not in use locally
- Verify the client-dev container is running: `docker compose ps`

### Database Connection Issues
- Check if PostgreSQL container is running: `docker compose ps monseen-db`
- Verify database credentials in `backend/.env`
- Ensure the database service is healthy: `docker compose logs monseen-db`

### Static Files Not Loading
- Run `make collectstatic`
- Check Nginx configuration for correct paths
- Verify volume mounts in docker-compose.yml

### Build Errors
- For Vite build errors, check `vite.config.js` configuration
- Ensure Node modules are installed: `docker compose exec client-dev npm install`
- Clear Vite cache volume: `docker compose down -v && make build-dev`

## 📊 Monitoring

- **Flower Dashboard**: http://localhost:5558
  - Username: admin
  - Password: admin1234
- **Logs**: `make show-logs`
- **Container Status**: `docker compose ps`

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Make your changes
4. Run tests and linting: `make test && make flake8 && make black-check`
5. Submit a pull request

## 📝 License

[Your License Here]

## 🆘 Support

For issues and questions, please [open an issue](your-repo-issues-link) on the repository.

---

**Happy Coding! 🎉**

This README provides comprehensive documentation for your project starter setup. You can customize the project name, repository links, and specific configurations based on your actual project needs.