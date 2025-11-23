# Deployment Guide

This guide provides detailed instructions for deploying your Spring Boot application to various cloud platforms.

## ⚠️ Important: Vercel Limitation

**Vercel does not support Spring Boot (Java) applications natively.** Vercel is designed for:
- Static sites and JAMstack applications
- Serverless functions (Node.js, Python, Go, Ruby)

**For Java/Spring Boot, use the alternatives below.**

---

## 🚂 Railway (Recommended - Easiest)

Railway is the simplest way to deploy Spring Boot applications.

### Option 1: Using Railway CLI

```bash
# Install Railway CLI
npm i -g railway

# Login to Railway
railway login

# Initialize project
railway init

# Deploy
railway up

# Open your deployed app
railway open
```

### Option 2: Using Railway Dashboard

1. Go to [railway.app](https://railway.app)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Connect your repository
5. Railway auto-detects Dockerfile and deploys
6. Get your public URL from the dashboard

### Environment Variables on Railway

Add these in the Railway dashboard:
- `SPRING_PROFILES_ACTIVE=prod`
- `PORT=8080` (Railway sets this automatically)

---

## 🎨 Render

Render provides free hosting for web services with Docker support.

### Deployment Steps:

1. Push your code to GitHub
2. Go to [render.com](https://render.com)
3. Click "New +" → "Web Service"
4. Connect your GitHub repository
5. Configure:
   - **Name**: spring-vercel-app
   - **Environment**: Docker
   - **Instance Type**: Free
6. Click "Create Web Service"

The `render.yaml` file in this project will be auto-detected.

### Manual Configuration (if needed):

- **Build Command**: (Leave empty - uses Dockerfile)
- **Start Command**: (Leave empty - uses Dockerfile)
- **Health Check Path**: `/actuator/health`

---

## ☁️ Google Cloud Run

Cloud Run is perfect for containerized applications with pay-per-use pricing.

### Prerequisites:
- Google Cloud account
- gcloud CLI installed

### Deployment Steps:

```bash
# Set your project ID
export PROJECT_ID=your-project-id
gcloud config set project $PROJECT_ID

# Enable required APIs
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.gcr.io

# Build and push to Google Container Registry
gcloud builds submit --tag gcr.io/$PROJECT_ID/spring-vercel-app

# Deploy to Cloud Run
gcloud run deploy spring-vercel-app \
  --image gcr.io/$PROJECT_ID/spring-vercel-app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 8080 \
  --set-env-vars SPRING_PROFILES_ACTIVE=prod

# Get the URL
gcloud run services describe spring-vercel-app --region us-central1
```

---

## 🔶 AWS Elastic Beanstalk

AWS Elastic Beanstalk provides automatic scaling and management.

### Prerequisites:
- AWS account
- EB CLI installed

### Deployment Steps:

```bash
# Install EB CLI
pip install awsebcli

# Initialize EB application
eb init -p docker spring-vercel-app

# Create environment and deploy
eb create spring-vercel-env

# Open application
eb open

# Update application
eb deploy
```

### Using JAR instead of Docker:

```bash
# Build JAR
./gradlew build

# Initialize for Java platform
eb init -p java-17 spring-vercel-app

# Deploy
eb create spring-vercel-env
```

---

## 💜 Heroku

Heroku offers simple deployment with a generous free tier.

### Prerequisites:
- Heroku account
- Heroku CLI installed

### Deployment Steps:

```bash
# Login to Heroku
heroku login

# Create Heroku app
heroku create your-app-name

# Set buildpack for Java
heroku buildpacks:set heroku/java

# Or use Docker
heroku stack:set container

# Add environment variables
heroku config:set SPRING_PROFILES_ACTIVE=prod

# Deploy
git push heroku main

# Open application
heroku open

# View logs
heroku logs --tail
```

---

## 🐳 Docker Deployment (Self-Hosted)

Deploy to any server that supports Docker.

### Build and Run:

```bash
# Build image
docker build -t spring-vercel-app .

# Run locally
docker run -p 8080:8080 spring-vercel-app

# Run with environment variables
docker run -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  spring-vercel-app

# Run in background
docker run -d -p 8080:8080 \
  --name spring-app \
  --restart unless-stopped \
  spring-vercel-app
```

### Using Docker Compose:

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=prod
    restart: unless-stopped
```

Run with:
```bash
docker-compose up -d
```

---

## 🔵 Azure App Service

Deploy to Microsoft Azure's fully managed platform.

### Using Azure CLI:

```bash
# Login
az login

# Create resource group
az group create --name SpringAppRG --location eastus

# Create App Service plan
az appservice plan create \
  --name SpringAppPlan \
  --resource-group SpringAppRG \
  --sku B1 \
  --is-linux

# Create web app
az webapp create \
  --name your-spring-app \
  --resource-group SpringAppRG \
  --plan SpringAppPlan \
  --deployment-container-image-name your-dockerhub/spring-vercel-app:latest

# Configure port
az webapp config appsettings set \
  --name your-spring-app \
  --resource-group SpringAppRG \
  --settings WEBSITES_PORT=8080
```

---

## 🌐 DigitalOcean App Platform

Simple deployment with automatic SSL and scaling.

### Deployment Steps:

1. Go to [cloud.digitalocean.com](https://cloud.digitalocean.com)
2. Click "Create" → "Apps"
3. Connect your GitHub repository
4. Configure:
   - **Type**: Web Service
   - **Dockerfile Path**: Dockerfile
   - **HTTP Port**: 8080
5. Add environment variables:
   - `SPRING_PROFILES_ACTIVE=prod`
6. Click "Next" through the steps and "Launch"

---

## 📊 Comparison Table

| Platform | Difficulty | Free Tier | Cold Starts | Best For |
|----------|-----------|-----------|-------------|----------|
| Railway | ⭐ Easy | ✅ Yes | No | Quick deploys |
| Render | ⭐ Easy | ✅ Yes | Yes (free) | Hobbyists |
| Google Cloud Run | ⭐⭐ Medium | ✅ Yes | Yes | Pay-per-use |
| Heroku | ⭐ Easy | ⚠️ Limited | Yes (free) | Prototypes |
| AWS EB | ⭐⭐⭐ Hard | ⚠️ Limited | No | Enterprise |
| Azure | ⭐⭐⭐ Hard | ✅ Yes | No | .NET devs |
| DigitalOcean | ⭐⭐ Medium | ❌ No | No | Simple VMs |

---

## 🔍 Health Checks

All platforms should use this health check endpoint:
```
/actuator/health
```

Configure in your platform's settings for automatic restarts if the app becomes unhealthy.

---

## 🔐 Environment Variables

Common environment variables to set:

| Variable | Value | Description |
|----------|-------|-------------|
| `SPRING_PROFILES_ACTIVE` | `prod` | Activates production profile |
| `PORT` | `8080` | Server port (usually auto-set) |
| `JAVA_OPTS` | `-Xmx512m` | JVM memory settings |

---

## 📝 Post-Deployment Checklist

- [ ] Health check endpoint responding
- [ ] All API endpoints working
- [ ] CORS configured correctly
- [ ] Environment variables set
- [ ] Logs accessible
- [ ] Custom domain configured (if needed)
- [ ] SSL certificate active (usually automatic)
- [ ] Monitoring/alerts set up

---

## 🆘 Troubleshooting

### Application won't start
1. Check logs for errors
2. Verify Java 17 is being used
3. Check memory limits (increase if needed)
4. Ensure PORT environment variable is set correctly

### 502/504 Gateway errors
1. Check health check endpoint
2. Verify application is listening on correct port
3. Increase startup timeout if needed

### Out of Memory errors
Add Java options:
```bash
JAVA_OPTS="-Xmx512m -Xms256m"
```

---

## 📞 Need Help?

- Check platform-specific documentation
- Review application logs
- Test locally with Docker first
- Ensure health check endpoint works

---

**Recommendation**: Start with **Railway** for the easiest deployment experience, then consider other platforms based on your scaling needs.

