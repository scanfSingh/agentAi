# Quick Start Guide

Get your Spring Boot application running in 5 minutes!

## Prerequisites

- **Java 17+** - [Download here](https://adoptium.net/)

Check your installation:
```bash
java -version
./gradlew --version
```

## 🚀 Run Locally (3 Options)

### Option 1: Use the convenience script
```bash
./run-local.sh
```

### Option 2: Use Make
```bash
make run
```

### Option 3: Use Gradle directly
```bash
./gradlew bootRun
```

## ✅ Test the Application

Once running, open your browser or use curl:

```bash
# Welcome message
curl http://localhost:8080/api/

# Hello endpoint
curl http://localhost:8080/api/hello

# Status check
curl http://localhost:8080/api/status

# Personalized greeting
curl http://localhost:8080/api/greet/YourName

# Health check
curl http://localhost:8080/actuator/health
```

## 🐳 Run with Docker

```bash
# Build
docker build -t spring-vercel-app .

# Run
docker run -p 8080:8080 spring-vercel-app
```

Or use Make:
```bash
make docker-build
make docker-run
```

## ☁️ Deploy to Cloud (Railway - Easiest)

```bash
# Install Railway CLI
npm i -g railway

# Login and deploy
railway login
railway init
railway up
```

That's it! Your app is live! 🎉

## 📚 Next Steps

- Read [README.md](README.md) for full documentation
- Check [DEPLOYMENT.md](DEPLOYMENT.md) for other deployment options
- Explore the code in `src/main/java/com/example/springvercel/`

## 🆘 Troubleshooting

**Port 8080 already in use?**
```bash
# macOS/Linux
lsof -ti:8080 | xargs kill -9

# Or change the port
export PORT=9090
./gradlew bootRun
```

**Gradle wrapper not working?**
- Make sure gradlew is executable: `chmod +x gradlew`

**Java version mismatch?**
- Install Java 17 from https://adoptium.net/

## 🛠️ Common Commands

```bash
# Build without tests
make build

# Run tests
make test

# Clean build
make clean

# See all commands
make help
```

## 📖 API Documentation

Visit http://localhost:8080/api/ after starting the application to see all available endpoints.

---

**Need more help?** Check out the full [README.md](README.md) or [DEPLOYMENT.md](DEPLOYMENT.md)!

